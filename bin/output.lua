package.path = package.path .. ';../util/?.lua'
require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'nngraph'
require 'bceCriterion'

local loader = require 'loadData'
local predict = require 'predict'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
-- training option
cmd:option('-lr', 0.0001, 'learning rate')
cmd:option('-decay', 'log', 'how learning rate decay(linear, log, no)')
cmd:option('-rho', 20, 'maximum BPTT steps')
cmd:option('-weight', 5, 'weight used to balance loss')
cmd:option('-cv', 5, 'cross-validation group')
cmd:option('-epoch', 0, 'the trained epoch we use')
cmd:option('-print_every', 27, 'how many steps between printing out the loss')
--rnn layer
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

--model base name
if opt.decay == 'log' or opt.decay == 'linear' then
	if opt.dropout <= 0 then
		base = string.format("%s_hs%d_w%d_cv%d", opt.decay, opt.hiddenSize[1], opt.weight, opt.cv)
	else
		base = string.format("%s_hs%d_w%d_dp%.2f_cv%d", opt.decay, opt.hiddenSize[1], opt.weight, opt.dropout, opt.cv)
	end
else
	if opt.dropout <= 0 then
		base = string.format("hs%d_w%d_lr.0e_cv%d", opt.hiddenSize[1], opt.weight, args.lr, opt.cv)
	else
		base = string.format("hs%d_w%d_lr.0e_dp%.2f_cv%d", opt.hiddenSize[1], opt.weight, args.lr, opt.dropout, opt.cv)
	end
end

local mfile = string.format("%s_ep%d.t7", base, opt.epoch)
mfile = paths.concat('../output', opt.savepath, mfile)

local d = torch.load(mfile)
local model = d.model

local multi_data = loader.load_data('multi', opt.r)
local data = loader.CVset(opt.cv, multi_data) --cv dataset

local outputs = {}
for i = 1, data.size do
	input, target = data:next_sample()
	model:zeroGradParameters()

    -- forward
    local output = model:forward(input)
	
	outputs[#outputs + 1] = output 
	if i% opt.print_every ==0 then
		local x = {}  
		local y = {}  
		for j = 1, 250 do
			table.insert(x,target[j]:squeeze())  
		   	table.insert(y,output[j]:squeeze())  
		end  
  
		x = torch.Tensor(x)  
		y = torch.Tensor(y)  
      
		local pfile = string.format("out_%s_i%d_ep%d.png", base, i/opt.print_every, opt.epoch)
		gnuplot.pngfigure(pfile)  
		gnuplot.plot({x},{y})  
		gnuplot.plotflush()  
	end
end
