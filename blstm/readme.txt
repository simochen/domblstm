1.训练模型
	th main.lua
  选择参数
-lr 		学习速率 		默认为0.001
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为20
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-epoch		训练集循环次数	默认为100
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为576(训练集大小)

2.继续训练模型
	th retrainTest.lua

  选择参数
-lr 		学习速率 		默认为0.001
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为20
-last_epoch	上一次训练的epoch	默认为1
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为576(训练集大小)
将无限循环训练

3.测试模型训练情况(输出训练集loss和交叉验证集loss)
	th testfile.lua
-start		起始epoch	默认为1
-ed		结束epoch	默认为20
-lr 		学习速率 		默认为0.001
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为20
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为576(训练集大小)

4.输出模型在交叉验证集的预测结果
	th output.lua
-lr 		学习速率 		默认为0.001
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为20
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-epoch		预测模型的epoch	默认为20
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为576(训练集大小)

5.输出模型在训练集的预测结果
	th outputTrain.lua
-lr 		学习速率 		默认为0.001
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为20
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-epoch		预测模型的epoch	默认为20
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为576(训练集大小)

