require 'torch'
require 'nn'
require 'rnn'
require 'bceCriterion'

local loader = require 'loadData'
local predict = require 'predict'
local multi_data = loader.load_data('multi')

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-start', 1, 'start epoch')
cmd:option('-ed', 20, 'end epoch')
cmd:option('-lr', 0.001, 'learning rate')
cmd:option('-rho', 1100, 'maximum BPTT steps')
cmd:option('-weight', 10, 'weight used to balance loss')
cmd:option('-hiddenSize', 10, 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-print_every', 5, 'how many epochs between printing out the loss')
cmd:option('-save_every', 5, 'how many epochs between saving the loss')
cmd:text()

local opt = cmd:parse(arg)

opt.trainG = torch.Tensor{1,2,3,4}
opt.cv = 5

local criterion = nn.SequencerCriterion(nn.bceCriterion())

local trainset = loader.Trainset(opt, multi_data)
local cvset = loader.CVset(opt, multi_data)

tloss = {}
cvloss = {}

for i = opt.start, opt.ed do
	mfile = string.format("hs%d_lr%.0e_w%d_tg1234_ep%d.t7",opt.hiddenSize, opt.lr, opt.weight, i);
	print(mfile)
	model = torch.load(mfile)
	
	terr = predict(model, criterion, trainset, opt)
	print(terr)
	cverr = predict(model, criterion, cvset, opt)
	print(cverr)
	
	tloss[#tloss +1] = terr;
	cvloss[#cvloss +1] = cverr;
	
	if #tloss % opt.save_every == 0 then
		lossfile = string.format("loss_hs%d_lr%.0e_w%d_tg1234.t7",opt.hiddenSize, opt.lr, opt.weight);
		torch.save(lossfile, {opt.start, i, tloss, cvloss})
	end
	if #tloss % opt.print_every == 0 then
		print(opt.start, i)
		print(tloss)
		print(cvloss)
	end
end
	