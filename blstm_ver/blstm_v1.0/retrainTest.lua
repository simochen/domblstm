require 'torch'
require 'math'

local loader = require 'loadData'
local retrain = require 'retrain'
local predict = require 'predict'

local multi_data = loader.load_data('multi')

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-lr', 0.001, 'learning rate')
cmd:option('-weight', 20, 'weight used to balance loss')
cmd:option('-last_epoch', 1, 'last trained epoch')
cmd:option('-hiddenSize', 10, 'size of hidden layer')
cmd:option('-inputSize', 25, 'size of input layer')
cmd:option('-epoch', 1, 'number of epoch')
cmd:option('-print_every', 100, 'how many steps between printing out the loss')
cmd:option('-save_every', 432, 'how many steps between saving the model')
cmd:text()

local opt = cmd:parse(arg)

opt.trainG = torch.Tensor{1,2,3}
opt.cv = 4

local trainset = loader.Trainset(opt, multi_data)
-- train sigmoid and requ versions
model1, criterion = retrain(opt, trainset)
-- TODO: uncomment once you implement requ
--opt.trainG = torch.Tenser{1,2,4}
--model2 = train(opt, multi_data)

--cross-validation
local cvset = loader.CVset(opt, multi_data)
losses = predict(model1, criterion, cvset)
print(losses)