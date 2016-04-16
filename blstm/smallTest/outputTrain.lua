require 'torch'
require 'math'

local loader = require 'loadData'
local train = require 'train'
local predict = require 'predict'

local multi_data = loader.load_data('multi')

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-lr', 0.001, 'learning rate')
cmd:option('-rho', 1100, 'maximum BPTT steps')
cmd:option('-weight', 10, 'weight used to balance loss')
cmd:option('-hiddenSize', 10, 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-epoch', 20, 'the trained epoch we use')
cmd:option('-print_every', 3, 'how many steps between printing out the loss')
cmd:option('-save_every', 400, 'how many steps between saving the model')
cmd:text()

local opt = cmd:parse(arg)

opt.trainG = torch.Tensor{1,2,3,4}
opt.cv = 5

mfile = string.format("hs%d_lr%.0e_w%d_tg1234_ep%d.t7",opt.hiddenSize, opt.lr, opt.weight, opt.epoch)
model = torch.load(mfile)

local data = loader.Trainset(opt, multi_data) --cv dataset

outputs = {}
for i = 1, data.size do
	input, target = data:next_sample()
	model:zeroGradParameters()

    -- forward
    local output = model:forward(input)
	
	outputs[#outputs + 1] = output
	
	if i% opt.print_every ==0 then
		x={}  
		y={}  
		for j=1,100 do
			table.insert(x,target[j]:squeeze())  
		   	table.insert(y,output[j]:squeeze())  
		end  
  
		x = torch.Tensor(x)  
		y = torch.Tensor(y)  
      
		pfile = string.format("outTrain_hs%d_lr%.0e_w%d_i%d_ep%d.png",opt.hiddenSize, opt.lr, opt.weight, i, opt.epoch)
		gnuplot.pngfigure(pfile)  
		gnuplot.plot({x},{y})  
		gnuplot.plotflush()  
	end
end

ofile = string.format("outTrain_hs%d_lr%.0e_w%d_tg1234_ep%d.t7",opt.hiddenSize, opt.lr, opt.weight, opt.epoch)
torch.save(ofile, {outputs, data.targets})

