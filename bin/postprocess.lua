package.path = package.path .. ';../util/?.lua'
require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'nngraph'
require 'gnuplot'

local loader = require 'loadData'
local predict = require 'predict'
local matio = require 'matio'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
-- training option
cmd:option('-lr', 0.0001, 'learning rate')
cmd:option('-decay', 'log', 'how learning rate decay(linear, log, recip, no)')
cmd:option('-rho', 20, 'maximum BPTT steps')
cmd:option('-weight', 5, 'weight used to balance loss')
cmd:option('-cv', 5, 'cross-validation group')
cmd:option('-r', 20, 'domain boundary expand length')
cmd:option('-type', 'multi', 'sequence type')
cmd:option('-sg', 1, 'single domain sequence group')
cmd:option('-epoch', 0, 'the trained epoch we use')
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

-- base name
if opt.decay == 'log' or opt.decay == 'linear' or opt.decay == 'recip' then
	if opt.dropout <= 0 then
		base = string.format("%s_hs%d_w%d_cv%d_ep%d", opt.decay, opt.hiddenSize[1], opt.weight, opt.cv, opt.epoch)
	else
		base = string.format("%s_hs%d_w%d_dp%.2f_cv%d_ep%d", opt.decay, opt.hiddenSize[1], opt.weight, opt.dropout, opt.cv, opt.epoch)
	end
else
	if opt.dropout <= 0 then
		base = string.format("hs%d_w%d_lr%.0e_cv%d_ep%d", opt.hiddenSize[1], opt.weight, opt.lr, opt.cv, opt.epoch)
	else
		base = string.format("hs%d_w%d_lr%.0e_dp%.2f_cv%d_ep%d", opt.hiddenSize[1], opt.weight, opt.lr, opt.dropout, opt.cv, opt.epoch)
	end
end

-- load model
local mfile = string.format("%s.t7", base)
mfile = paths.concat('../output', opt.savepath, mfile)

local d = torch.load(mfile)
local model = d.model

local cvdata = loader.load_data(opt.type, opt.r)
if opt.type == 'multi' then
	data = loader.CVset(opt.cv, cvdata)
elseif opt.type == 'single' then
	data = loader.CVset(opt.sg, cvdata) --cv dataset
end

local y = {}
for i = 1, data.size do
	-- prediction
	input, target = data:next_sample()
	model:zeroGradParameters()

	-- forward
	local output = model:forward(input)
	for j = 1, table.maxn(output) do
		table.insert(y, output[j][1][1])
	end
end

y = torch.Tensor{y}
-- save to mat file
if opt.type == 'multi' then
	outfile = string.format("%s.mat", base)
elseif opt.type == 'single' then
	outfile = string.format("%s_sg%d.mat", base, opt.sg)
end
outfile = paths.concat('../output', opt.savepath, outfile)

matio.save(outfile,  {y = y})
