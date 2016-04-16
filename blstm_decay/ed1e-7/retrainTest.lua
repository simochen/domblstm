require 'torch'
require 'math'

local loader = require 'loadData'
local retrain = require 'retrain'

local multi_data = loader.load_data('multi')

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-startlr', 0.0001, 'learning rate at t=0')
cmd:option('-minlr', 0.000001, 'minimum learning rate')
cmd:option('-decay', true, 'if learning rate decay')
cmd:option('-saturate', 300, 'epoch at which linear decayed LR will reach minlr')
cmd:option('-rho', 1100, 'maximum BPTT steps')
cmd:option('-weight', 10, 'weight used to balance loss')
cmd:option('-last_epoch', 1, 'last trained epoch')
cmd:option('-earlystop', 50, 'maximum number of epochs to wait to find a better local minima for early-stopping')
cmd:option('-hiddenSize', 10, 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-print_every', 100, 'how many steps between printing out the loss')
cmd:option('-save_every', 5, 'how many epochs between saving the model')
cmd:option('-dropout', 0, 'apply dropout with this probability after brnn layer. dropout <= 0 disables it.')
cmd:text()

local opt = cmd:parse(arg)

opt.trainG = torch.Tensor{1,2,3,4}
opt.cv = 5

local trainset = loader.Trainset(opt, multi_data)
local cvset = loader.CVset(opt, multi_data)

model, criterion, args = retrain(opt, trainset, cvset)
