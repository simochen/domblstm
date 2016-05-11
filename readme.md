###Bidirectional-LSTM Model
#####1. 训练模型
	th main.lua
  选择参数
  
```
**Training**
-startlr 	起始学习速率 		默认为1e-4
-minlr		最小学习速率		默认为1e-6
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-saturate	学习速率衰减次数	默认为300
-rho 		最大后向传播次数 	默认为20
-momentum	momentum		默认为0
-cv			交叉验证集		默认为5
-weight		代价权重			默认为5
-epoch		训练集循环次数	默认为1000
-earlystop	最大不降低的epoch数	默认为30
-save_every	保存模型间隔		默认为3(epoch)
		
**rnn layer**
-rnn		采用什么单元		默认为‘lstm’(‘gru’,’rnn’)
-hiddenSize	隐藏层大小		默认为'{10}'
-inputSize	输入层大小		默认为25
-dropout	dropout参数		默认为0

**data**
-savepath	模型保存路径		默认为''
```

#####2. 继续训练模型
	th runRetrain.lua

  选择参数
  
```
**Training**
-startlr 	起始学习速率 		默认为1e-4
-minlr		最小学习速率		默认为1e-6
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-saturate	学习速率衰减次数	默认为300
-rho 		最大后向传播次数 	默认为20
-momentum	momentum		默认为0
-cv			交叉验证集		默认为5
-weight		代价权重			默认为5
-last_epoch	上次训练epoch数	默认为0
-earlystop	最大不降低的epoch数	默认为50
-save_every	保存模型间隔		默认为3(epoch)
		
**rnn layer**
-rnn		采用什么单元		默认为‘lstm’(‘gru’,’rnn’)
-hiddenSize	隐藏层大小		默认为'{10}'
-inputSize	输入层大小		默认为25
-dropout	dropout参数		默认为0

**data**
-savepath	模型保存路径		默认为''
```


#####3. 测试模型训练情况(输出训练集loss和交叉验证集loss)
	th showloss.lua
```
**Training**
-lr 		学习速率 			默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-weight		代价权重			默认为5
-cv			交叉验证集		默认为5
-epoch		采用的模型训练次数	默认为0

**rnn layer**
-hiddenSize	隐藏层大小		默认为'{10}'
-inputSize	输入层大小		默认为25
-dropout	dropout参数		默认为0

**data**
-savepath	模型保存路径		默认为''
```

#####4. 输出模型在交叉验证集的预测结果
	th output.lua
```
**Training**
-lr 		学习速率 			默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-rho 		最大后向传播次数 	默认为20
-weight		代价权重(无法改变)	默认为5
-cv			交叉验证集		默认为5
-epoch		采用的模型训练次数	默认为0
-print_every模型输出间隔		默认为27

**rnn layer**
-hiddenSize	隐藏层大小		默认为'{10}'
-inputSize	输入层大小		默认为25
-dropout	dropout参数		默认为0

**data**
-savepath	模型保存路径		默认为''
```

#####5. 输出模型在训练集的预测结果
	th outputTrain.lua
```
**Training**
-lr 		学习速率 			默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-rho 		最大后向传播次数 	默认为20
-weight		代价权重			默认为5
-cv			交叉验证集		默认为5
-epoch		采用的模型训练次数	默认为0
-print_every模型输出间隔		默认为99

**rnn layer**
-hiddenSize	隐藏层大小		默认为'{10}'
-inputSize	输入层大小		默认为25
-dropout	dropout参数		默认为0

**data**
-savepath	模型保存路径		默认为''
```

#####6. 输出模型预测结果到mat文件
	th postprocess.lua
```
**Training**
-lr 		学习速率 			默认为1e-4
-decay		学习速率衰减方式	默认为’log’(‘linear’,’no’)
-rho 		最大后向传播次数 	默认为20
-weight		代价权重			默认为5
-cv			交叉验证集		默认为5
-epoch		采用的模型训练次数	默认为0

**rnn layer**
-hiddenSize	隐藏层大小		默认为'{10}'
-inputSize	输入层大小		默认为25
-dropout	dropout参数		默认为0

**data**
-savepath	模型保存路径		默认为''
```

