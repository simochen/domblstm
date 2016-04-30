addpath ../util
genData
clear all
load pred.mat
load multi.mat
msNum = 86;
mdNum = seq_poi(msNum+1)-1;
ndo = evaluate(ms_cnt, ms_poi, md_range, seq_cnt(1:msNum), seq_poi(1:msNum), range(1:mdNum,:));

load single.mat
ssNum = 45;
ndo = evaluate(ss_cnt, ss_poi, sd_range, ones(1,ssNum), 1:ssNum, range(1:ssNum,:));
