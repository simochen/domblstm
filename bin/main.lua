package.path = package.path .. ';../util/?.lua'
require 'torch'
require 'math'

local loader = require 'loadData'
local train = require 'train'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
--training
cmd:option('-startlr', 0.0001, 'learning rate at t=0')
cmd:option('-minlr', 0.000001, 'minimum learning rate')
cmd:option('-decay', 'log', 'how learning rate decay(linear, log, no)')
cmd:option('-saturate', 300, 'epoch at which linear decayed LR will reach minlr')
cmd:option('-rho', 20, 'maximum BPTT steps')
cmd:option('-cv', 5, 'cross-validation group')
cmd:option('-r', 20, 'domain boundary expand length')
cmd:option('-weight', 5, 'weight used to balance loss')
cmd:option('-epoch', 1000, 'number of epoch')
cmd:option('-earlystop', 30, 'maximum number of epochs to wait to find a better local minima for early-stopping')
cmd:option('-save_every', 3, 'how many epochs between saving the model')
--rnn layer
cmd:option('-rnn', 'lstm', 'which rnn unit to use(lstm, gru, rnn)')
cmd:option('-hiddenSize', '{10}', 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-dropout', 0, 'apply dropout with this probability after brnn layer. dropout <= 0 disables it.')
--data
cmd:option('-savepath', '', 'path to directory where experiment log (includes model) will be saved')
cmd:text()

local opt = cmd:parse(arg)
opt.hiddenSize = loadstring(" return "..opt.hiddenSize)()

opt.trainG = {}
j = 0
for i = 1, 5 do
	if i ~= opt.cv then
		j = j + 1
		opt.trainG[j] = i
	end
end
opt.trainG = torch.Tensor(opt.trainG)

local multi_data = loader.load_data('multi', opt.r)

local trainset = loader.Trainset(opt, multi_data)
local cvset = loader.CVset(opt, multi_data)

model, criterion, args = train(opt, trainset, cvset)
