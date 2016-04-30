###1. DOMpro
1. download dompro1.0 和 sspro4 并解压
2. 搭建 sspro4

	(1) 修改 /sspro4/configure.pl 文件
		
		$install_dir = “/home/chenxiao/sspro4/”;
	(2) 在 /sspro4/ 目录下运行
		
		./configure.pl

3. 搭建 dompro1.0
	
	(1) 修改 /dompro1.0/configure.pl 文件
		
		$install_dir = "/home/chenxiao/dompro1.0/";
		$pspro_dir = "/home/chenxiao/sspro4/";
	(2) 在 /dompro1.0/ 目录下运行
		
		./configure.pl

4. 修改 /dompro1.0/script/domain_pre.pl 文件,
   将 domain 预测输出结果写入文件

5. 在数据集上测试 dompro
		
		runDompro.pl type[single, multi] start end

### 2. DROP
1. 搭建 psi-pred
	
	(1) 安装 tcsh
		
		sudo apt-get install tcsh
	(2) 编译
	
		cd /psipred/src
		make
		make install
	(3) 修改 /psipred/runpsipred
		
		set dbname = /home/mpiuser/ur90/uniref90
		set ncbidir = /home/chenxiao/blast/bin
	(4) 运行例子
		
		./runpsipred ./example/example.fasta

2. 下载 svm_light v6.01 (不要最新版)
	
	(1) 该版本为32位程序，在64位机上运行32位程序需要安装几个库
		
		sudo apt-get install libc6:i386
		sudo apt-get install libstdc++5
		sudo apt-get install libstdc++5:i386
	(2) 对于服务器，没有下载 sudo 的权限,
    下载 svm_light v6.01 的源代码，在本地编译
		
		cd ./svm_light
		make
    生成 svm_classify 和 svm_learn
3. 修改 ~/.bashrc

		vi ~/.bashrc
   在最后一行添加
		
		DROP_DIR=/home/chenxiao/DROP
4. 修改 /DROP/ref/option.txt
	
		NR_DB = /home/mpiuser/ur90/uniref90
		BLAST_DIR = /home/chenxiao/blast/bin
		PSIPRED_DIR = /home/chenxiao/psipred
		SVM_DIR = /home/chenxiao/svm_light
5. 错误修正
	(1) /DROP/runDROP
		
		#cd ${DROP_DIR}		-注释该行
	(2) /DROP/Script/MakePSS.sh
	
		所有 ${2} 后加 / , 变为 ${2}/
	
	(3) /DROP/Script/runSVMLight.sh
	
		所有 ${3} 后加 / , 变为 ${3}/
6. 运行例子
	
		./runDROP [fastaFile] [outputDir]
   结果输出在 [outputDir]/prediction.txt, 格式为

		TARGET_ID | LINKER_ST , LNKER_EN | LNKER_LENGTH | PEAK_VALUE | TARGET_SIZE | PEAK_POS |

7. 批量运行 DROP

	(1) 修改 runDROP, /Script/MakePSSM.sh, MakePSS.sh, RunSVMLight.sh
	
	(2) 在数据集上运行 DROP
		
		runDROP.pl $type $start $end

### 3. ThreaDom
1. 搭建 I-TASSER2.1
	
	将数据库解压到 /I-TASSER2.1/ 路径下
2. 下载 DSSP、DomainParser 至 /lib/ 路径下
	
	命名为 dssp, domainparser2
3. 编辑 /threadom/config.ini
	
		ThreaDom_path = “/home/chenxiao/threadom”
		I-TASSER_path = “/home/chenxiao/I-TASSER2.1”
		DSSP_path = “/home/chenxiao/lib”
		DomainParser_path = “/home/chenxiao/lib”
		pdb_all_path = “/home/chenxiao/I-TASSER2.1/PDB”
	
		Data_path = “/home/chenxiao/threa_data”
		Data_dir_base = “/home/chenxiao/threa_large”
		Dataset_name = “threa_data”
4. 在 /threadom/ 目录下运行
	
		perl CONFIGURATE.pl
5. Run LOMETS for ThreaDom
	
		./runLOMETs4ThreaDom.pl -libdir ~/I-TASSER2.1 -seqname [sequence name] -datadir ~/threa_data -javadir /usr/share/java
6. Run ThreaDom
 	
 		cd Threadom_path
 		./Threadom.pl -seqname [sequence name]     #domain predition
 		./detectdcd.pl -seqname [sequence name]    #boudary refinement and discontinuous domain detection
 		./draw.pl         #draw the figure of DC-score

7. 在数据集上批量运行 ThreaDom
	
		./runThreaDom.pl $type $start $end

8. (*) domainparser2 为32位程序，且无源代码
	
	分别编写 runI-TASSER.pl、runThreadomOnly.pl 将 I-TASSER 与 ThreaDom 分开运行
	在服务器端运行 I-TASSER，在本地运行 ThreaDom 