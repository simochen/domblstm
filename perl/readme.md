#说明

这一部分为本地数据库搭建和特征提取。

程序在 `perl` 下运行。

文件说明如下：

* doc

	说明文档，给出各部分程序说明以及运行示例。
	
* lib

	特征提取时用到的程序，包括：
	
	* `blast`    - 产生 PSSM 矩阵
	
	* `SCRATCH`  - 预测蛋白质二级结构和可溶解信息
	
	* `DISOPRED` - 预测不规则信息
	
	由于上述程序是既有的程序，且比较大，实际上没有放在文件夹中。可在网站或服务器上下载。
	
* genDataset

	本地数据库搭建程序。
	
* genFeature

	特征提取程序。
	
* domainDS

	PDB 和 CATH 序列文件。
	

生成的本地数据库在根目录下的`dataset`文件夹中。