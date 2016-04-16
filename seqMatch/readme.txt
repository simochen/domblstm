1.改变multi_domain边界范围
(1) assignDom_multi.m
    改变r的值,运行
(2) 运行group5.m
(3) 将 group5.mat 复制到torch7程序文件夹

2.截取 multi_domain 序列片段 按顺序排列
(1) segment10
    生成 segment10.m
mseg	  1*720 cell     对于每个cell:[1D] 1 * segNum 值为segment中心位置
mneigh	  1*720 cell     对于每个cell:[2D] winSize * segNum 每列为一个segment
mseg_X	  1*720 cell     对于每个cell:[2D] (segNum * winSize) * featSize(25)
mseg_y	  1*720 cell
mseg_y0	  1*720 cell
(2) group5_seg
    生成 group5_seg.m
mg          1*5 cell
mg_seg_X    144*5 cell	    对于每个cell:[2D] (segNum * winSize) * featSize(25) 
mg_seg_y    144*5 cell
mg_seg_y0   144*5 cell

*2.截取 multi_domain 序列片段 乱序
(1) seg10_rand
    生成 seg10_rand.m
mseg	  1*720 cell     对于每个cell:[1D] 1 * segNum 值为segment中心位置
mneigh	  1*720 cell     对于每个cell:[2D] winSize * segNum 每列为一个segment
mn_X	  1*720 cell     对于每个cell:[3D] winSize * segNum * featSize(25)
mn_y	  1*720 cell	  对于每个cell:[2D] winSize * segNum 
mn_y0	  1*720 cell
mg_seg_X   1*5 cell	  对于每个cell:[3D] winSize * segNum(sum) * featSize(25)
mg_seg_y   1*5 cell
mg_seg_y0  1*5 cell

RNN input format: seqlen * batchsize * featsize
		 winSize(11)              25
