require 'rnn'
require 'gnuplot'

--定义常量
batchSize = 8 	--mini batch的大小
--rnn在训练时所需考虑的时间最大长度，这也是Back propagation through time 所需经历的次数
rho = 100
hiddenSize = 20 --中间隐藏层的节点个数

--定义隐藏层的结构
--隐藏层r的类型是nn.Recurrent。后面跟的参数依次分别是：
--1. 本层中包含的节点个数，为hiddenSize
--2. 前一层（也就是输入层）到本层的连接。这里是一个输入为1，输出为hiddenSize的线性连接。
--3. 本层节点到自身的反馈连接。这里是一个输入为hiddenSize，输出也是hiddenSize的线性连接。
--4. 本层输入和反馈连接所用的激活函数。这里用的是Sigmoid。
--5. Back propagation through time所进行的最大的次数。这里是rho = 100
r = nn.Recurrent(
	hiddenSize, nn.Linear(1, hiddenSize),
	nn.Linear(hiddenSize, hiddenSize), nn.Sigmoid(),
	rho)

--定义整个网络的结构
--首先定义一个容器
rnn = nn.Sequential()
--添加刚才定义好的隐藏层r
rnn:add(nn.Sequencer(r))
--添加隐藏层到输出层的连接，是输入为20，输出为1的线性连接
rnn:add(nn.Sequencer(nn.Linear(hiddenSize, 1)))
--添加一层Sigmoid函数
rnn:add(nn.Sequencer(nn.Sigmoid()))
--这里在定义网络的时候，每个具体的模块都是用nn.Sequencer的括号给括起来的。nn.Sequencer是一个修饰模块。所有经过nn.Sequencer包装过的模块都变得可以接受序列的输入。
--举个例子，假设有一个模块本来能够接受一个2维的Tensor作为输入，并输出另一个2维的Tensor。如果想把一系列的2维Tensor依次输入给这个模块，需要写一个for循环来实现。有了nn.Sequencer的修饰后，只需要把这一系列的2维Tensor统一放到一个大的table里，然后一次性的丢给nn.Sequencer。nn.Sequencer会把table中的Tensor依次放入网络，并将网络输出的Tensor也依次放入一个大的table中返回。

--定义评判标准
criterion = nn.SequencerCriterion(nn.MSECriterion()) 

--训练网络参数(前向传播，后向传播，更新参数)
batchLoader = require 'MinibatchLoader'  
loader = batchLoader.create(batchSize)  
  
lr = 0.01		--learning Rate
i = 1
for n=1,6000 do  
	-- prepare inputs and targets  
   	local inputs, targets = loader:next_batch()  
  	
   	local outputs = rnn:forward(inputs)  
   	local err = criterion:forward(outputs, targets)  
   	print(i, err/rho)  
   	local gradOutputs = criterion:backward(outputs, targets)  
   	rnn:backward(inputs, gradOutputs)  
   	rnn:updateParameters(lr)  
   	rnn:zeroGradParameters()  
   	i = i + 1
end  
--需要重点说明的是输入和输出数据的格式。此处使用了MinibatchLoader（同目录下的MinibatchLoader.lua文件）来从data.t7（.t7为lua数据文件格式）中读取数据，每次读取8个序列，每个序列的时间长度是100。那么代码中inputs的类型是table，这个table中有100个元素，每个元素是一个2维8列1行的Tensor。在训练的时候，mini batch中8个序列中的每一个的第一个数据一起进入网络，接下来是8个排在第二的数据一起输入，如此迭代。

--当训练完成之后，用其中的组输入放进网络观察其输出：
inputs, targets = loader:next_batch()  
outputs = rnn:forward(inputs)  
  
x={}  
y={}  
for i=1,100 do  
   table.insert(x,inputs[i][{1,1}])  
   table.insert(y,outputs[i][{1,1}])  
end  
  
x = torch.Tensor(x)  
y = torch.Tensor(y)  
      
gnuplot.pngfigure('timer.png')  
gnuplot.plot({x},{y})  
gnuplot.plotflush()  