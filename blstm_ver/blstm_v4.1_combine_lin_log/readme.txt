【学习速率衰减】【dropout】【增加GRU单元选项】【修正无法设置布尔参数】

1.训练模型
	th main.lua
  选择参数
-startlr 	起始学习速率 	默认为1e-4
-minlr		最小学习速率	默认为1e-6
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-saturate	学习速率衰减次数	默认为300
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为10
-epoch		训练集循环次数	默认为1000
-earlystop	最大cover不降低的	默认为50
		epoch数
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为5(epoch)
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-rnn		采用什么单元	默认为‘lstm’(‘gru’,’rnn’)
-dropout	dropout参数	默认为0

2.继续训练模型
	th retrainTest.lua

  选择参数
-startlr 	起始学习速率 	默认为1e-4
-minlr		最小学习速率	默认为1e-6
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-saturate	学习速率衰减次数	默认为300
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为10
-last_epoch	上次训练epoch	默认为1
-earlystop	最大cover不降低的	默认为50
		epoch数
-print_every	输出间隔		默认为100
-save_every	保存模型间隔	默认为5(epoch)
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-rnn		采用什么单元	默认为‘lstm’(‘gru’,’rnn’)
-dropout	dropout参数	默认为0

3.测试模型训练情况(输出训练集loss和交叉验证集loss)
	th showloss.lua

-lr 		学习速率 		默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-weight		代价权重(无法改变)	默认为10
-epoch		采用的模型训练次数	默认为1
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-dropout	dropout参数	默认为0

4.输出模型在交叉验证集的预测结果
	th output.lua
-lr 		学习速率 		默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为10
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-epoch		预测模型的epoch	默认为20
-print_every	输出间隔		默认为27

5.输出模型在训练集的预测结果
	th outputTrain.lua
-lr 		学习速率 		默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-rho 		最大后向传播次数 	默认为1100
-weight		代价权重(无法改变)	默认为10
-hiddenSize	隐藏层大小	默认为10
-inputSize	输入层大小	默认为25
-epoch		预测模型的epoch	默认为20
-print_every	输出间隔		默认为99

