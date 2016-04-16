require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'gnuplot'
require 'bceCriterion'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-lr', 0.0001, 'learning rate')
cmd:option('-decay', true, 'if learning rate decay')
cmd:option('-weight', 10, 'weight used to balance loss')
cmd:option('-epoch', 1, 'the epoch we load')
cmd:option('-hiddenSize', 10, 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-dropout', 0, 'apply dropout with this probability after brnn layer. dropout <= 0 disables it.')
cmd:text()

local opt = cmd:parse(arg)

opt.trainG = torch.Tensor{1,2,3,4}
opt.cv = 5

if opt.dropout == 0 then
	opt.showdo = false
else
	opt.showdo = true
end

if opt.decay then
	mfile = string.format("hs%d_w%d_tg1234_ep%d.t7",opt.hiddenSize, opt.weight, opt.epoch)
else
	mfile = string.format("hs%d_w%d_lr%.0e_tg1234_ep%d.t7",opt.hiddenSize, opt.weight, opt.lr, opt.epoch)
end
data = torch.load(mfile)
tloss = data.tloss
cvloss = data.cvloss

t = torch.Tensor(tloss):div(576)
cv = torch.Tensor(cvloss):div(144)

if opt.decay then
	pfile = string.format("hs%d_w%d_tg1234.png",opt.hiddenSize, opt.weight)
else
	pfile = string.format("hs%d_w%d_lr%.0e_tg1234.png",opt.hiddenSize, opt.weight, opt.lr)
end

gnuplot.pngfigure(pfile)  
gnuplot.plot({t},{cv})  
gnuplot.plotflush() 