package.path = package.path .. ';../util/?.lua'
require 'torch'
require 'paths'
require 'nn'
require 'rnn'
require 'nngraph'
require 'gnuplot'
require 'bceCriterion'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-lr', 0.0001, 'learning rate')
cmd:option('-decay', 'log', 'how learning rate decay(linear, log, no)')
cmd:option('-weight', 5, 'weight used to balance loss')
cmd:option('-cv', 5, 'cross-validation group')
cmd:option('-epoch', 0, 'the epoch we load')
cmd:option('-hiddenSize', '{10}', 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-dropout', 0, 'apply dropout with this probability after brnn layer. dropout <= 0 disables it.')
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

mfile = string.format("%s_ep%d.t7", base, opt.epoch)
mfile = paths.concat('../output', opt.savepath, mfile)
					
data = torch.load(mfile)
tloss = data.tloss
cvloss = data.cvloss

t = torch.Tensor(tloss)
cv = torch.Tensor(cvloss)

pfile = string.format("%s.png", base)
pfile = paths.concat('../output', opt.savepath, pfile)
gnuplot.pngfigure(pfile)  
gnuplot.plot({t},{cv})  
gnuplot.plotflush() 