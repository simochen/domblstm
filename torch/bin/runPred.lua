package.path = package.path .. ';../util/?.lua'
require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'nngraph'
require 'gnuplot'

local loader = require 'loadData'
local matio = require 'matio'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
-- training option
cmd:option('-type', 'multi', 'sequence type')
cmd:option('-model', 1, 'the trained model we use')
--data
cmd:option('-savepath', '', 'path to directory where experiment log (includes model) will be saved')
cmd:text()

local opt = cmd:parse(arg)

-- base name
local base = string.format("model%d", opt.model)

-- load model
local mfile = string.format("%s.t7", base)
mfile = paths.concat('../model', mfile)

local d = torch.load(mfile)
local model = d.model

local data = loader.load_test_data(opt.type)

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
	outfile = string.format("%s_mul.mat", base)
elseif opt.type == 'single' then
	outfile = string.format("%s_sin.mat", base)
end
outfile = paths.concat('../model_pred', opt.savepath, outfile)

matio.save(outfile,  {y = y})
