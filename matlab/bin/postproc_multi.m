clear all
addpath ../util
load('../data/process/mg_vec_r20.mat');
opt = struct('win', 5, 'cutoff', [0.5, 0.5, 0.5], 'minBlen', 5, 'minArea', [0.1, 0.1, 0.1], 'minusArea', 0, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);
dir = 'boost_w5_md';
%dir = 'w5';
weight = 5;
param.cv = 2;
param.ep = 142;
param.md = 14;
%% load a model
%filename = sprintf('../data/postproc/%s/log_hs10_w%d_cv%d_ep%d.mat', dir, weight, param.cv, param.ep);
%filename = sprintf('../data/postproc/%s/hs10_w%d_lr1e-01_cv%d_ep%d.mat', dir, weight, param.cv, param.ep);
%load(filename)
%% load boost model
model_num = 1:param.md;
y = boost(dir, 'multi', param.cv, model_num);
%% prediction
pred = postproc(y, vec_group{param.cv}, opt);
for i = 1: numel(vec_group{param.cv})
    def(i).label = vec_group{param.cv}(i).yi;
    def(i).range = vec_group{param.cv}(i).rangei;
end
eval = evaluate(pred, def);
eval_print(eval);