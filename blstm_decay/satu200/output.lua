require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'bceCriterion'

local loader = require 'loadData'
local predict = require 'predict'

local multi_data = loader.load_data('multi')

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-lr', 0.0001, 'learning rate')
cmd:option('-decay', true, 'if learning rate decay')
cmd:option('-rho', 1100, 'maximum BPTT steps')
cmd:option('-weight', 20, 'weight used to balance loss')
cmd:option('-hiddenSize', 10, 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-epoch', 20, 'the trained epoch we use')
cmd:option('-print_every', 27, 'how many steps between printing out the loss')
cmd:text()

local opt = cmd:parse(arg)

opt.trainG = torch.Tensor{1,2,3,4}
opt.cv = 5

if opt.decay then
	mfile = string.format("hs%d_w%d_tg1234_ep%d.t7",opt.hiddenSize, opt.weight, opt.epoch)
else
	mfile = string.format("hs%d_w%d_lr%.0e_tg1234_ep%d.t7",opt.hiddenSize, opt.weight, opt.lr, opt.epoch)
end
data = torch.load(mfile)
model = data.model

local data = loader.CVset(opt, multi_data) --cv dataset

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
		for j=1,250 do
			table.insert(x,target[j]:squeeze())  
		   	table.insert(y,output[j]:squeeze())  
		end  
  
		x = torch.Tensor(x)  
		y = torch.Tensor(y)  
      
		pfile = string.format("out_hs%d_w%d_i%d_ep%d.png",opt.hiddenSize, opt.weight, i/opt.print_every, opt.epoch)
		gnuplot.pngfigure(pfile)  
		gnuplot.plot({x},{y})  
		gnuplot.plotflush()  
	end
end
--ofile = string.format("out_hs%d_lr%.0e_w%d_tg1234_ep%d.t7",opt.hiddenSize, opt.lr, opt.weight, opt.epoch)
--torch.save(ofile, {outputs, data.targets})
