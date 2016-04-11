require 'torch'
require 'math'

local train = require 'train'

local cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-lr', 0.01, 'learning rate')
cmd:option('-batchSize', 8, 'mini-batch size')
cmd:option('-hiddenSize', 20, 'size of hidden layer')
cmd:option('-inputSize', 1, 'size of input layer')
cmd:option('-epoch', 6000, 'number of epoch')
cmd:option('-print_every', 100, 'how many steps between printing out the loss')
cmd:option('-save_every', 10000, 'how many steps between saving the model')
cmd:text()

local opt = cmd:parse(arg)

batchLoader = require 'MinibatchLoader'  
loader = batchLoader.create(opt.batchSize) 

-- train sigmoid and requ versions
model, criterion = train(opt, loader)
-- TODO: uncomment once you implement requ


inputs, targets = loader:next_batch()  
outputs = model:forward(inputs)  
  
x={}  
y={}  
for i=1,100 do  
   table.insert(x,inputs[i][{1,1}])  
   table.insert(y,outputs[i][{1,1}])  
end  
  
x = torch.Tensor(x)  
y = torch.Tensor(y)  
      
gnuplot.pngfigure('timer1.png')  
gnuplot.plot({x},{y})  
gnuplot.plotflush()  