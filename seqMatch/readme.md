###1.改变multi_domain边界范围
(1) assignDom_multi.m
    改变r的值,运行
    
(2) 运行group5.m

(3) 将 group5.mat 复制到torch7程序文件夹

###2.截取 multi_domain 序列片段 按顺序排列
(1) segment10

生成 segment10.m

```
mseg	  1*720 cell     对于每个cell:[1D] 1 * segNum 值为segment中心位置
mneigh	  1*720 cell     对于每个cell:[2D] winSize * segNum 每列为一个segment
mseg_X	  1*720 cell     对于每个cell:[2D] (segNum * winSize) * featSize(25)
mseg_y	  1*720 cell
mseg_y0	  1*720 cell
```
(2) group5_seg

生成 group5_seg.m

```
mg          1*5 cell
mg_seg_X    144*5 cell	    对于每个cell:[2D] (segNum * winSize) * featSize(25) 
mg_seg_y    144*5 cell
mg_seg_y0   144*5 cell
```
###*2.截取 multi_domain 序列片段 乱序

(1) seg10_rand

生成 seg10_rand.m

```
mseg	  1*720 cell     对于每个cell:[1D] 1 * segNum 值为segment中心位置
mneigh	  1*720 cell     对于每个cell:[2D] winSize * segNum 每列为一个segment
mn_X	  1*720 cell     对于每个cell:[3D] winSize * segNum * featSize(25)
mn_y	  1*720 cell	  对于每个cell:[2D] winSize * segNum 
mn_y0	  1*720 cell
mg_seg_X   1*5 cell	  对于每个cell:[3D] winSize * segNum(sum) * featSize(25)
mg_seg_y   1*5 cell
mg_seg_y0  1*5 cell
```
RNN input format: 

	seqlen * batchsize * featsize
		     winSize(11)    25

###**2.截取 multi_domain 序列片段

(1) segment 函数

	segment(r, win, l, isRand, filename)

```
r: boundary region 拓展长度
winSize = 2*win+1
l: seg 截取拓展长度
isRand: 是否乱序
filename: 保存数据文件名
```
```
mg_seg_X   1*5 cell	  对于每个cell:[3D] winSize * segNum(sum) * featSize(25)
mg_seg_y   1*5 cell
mg_seg_y0  1*5 cell
```

(2) segment_all 函数

	segment_all(r, win, filename)

```
mg_seg_X   1*5 cell	  对于每个cell:[3D] winSize * segNum(sum) * featSize(25)
mg_seg_y   1*5 cell
mg_seg_y0  1*5 cell
```

(3) oversample 函数

	oversample(w, isRand, filename)
	
```
mg_seg_X   1*5 cell	  对于每个cell:[3D] winSize * segNum(sum) * featSize(25)
mg_seg_y   1*5 cell
mg_seg_y0  1*5 cell
```

### 3. 后处理 postproc.m
	postproc(s, win, cv, filename)
```
输入序列长度为2*s+1
平滑窗口大小为2*win+1
验证集为cv
模型输出文件名为filename
```

### 4. 评价预测结果
(1) overlap

	[common,olp] = overlap(range_pred, range_def)
range_pred, range_def 为一段domain的值

(2) domMeasure

	[n, ndo] = domMeasure(range_pred, range_def)
range_pred, range_def 为一条序列的值

(3) evaluate

	[trNum, precision, recall, ndo] = evaluate(s_cnt, s_poi, range_pred, seq_cnt, seq_poi, range_def)
range_pred, range_def 为验证集上的所有值

(4) divGroup — 数据集分组

保存为 mulgroup.mat

```
range_def	1*5 cell
sq_poi		1*5 cell
sq_cnt		1*5 cell
```

(5) result(th, ter, tcb, cb) — 生成预测结果

```
th: threshold (0,1)
ter: n-,c-terminal skip length
tcb: n-,c-terminal boundary combine res
cb: inner boundary combine res
```