clear all
addpath ../util
load('../data/process/mg_vec_r20.mat');
opt = struct('win', 5, 'cutoff', 0.5, 'minBlen', 5, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', 0.2);
param.cv = 5;
param.ep = 217;
filename = sprintf('../data/postproc/log_hs10_w5_cv%d_ep%d.mat', param.cv, param.ep);
load(filename)
pred = postproc(y, vec_group{param.cv}, opt);
for i = 1: numel(vec_group{param.cv})
    def(i).y = vec_group{param.cv}(i).yi;
    def(i).range = vec_group{param.cv}(i).rangei;
end
eval = evaluate(pred, def);
eval_print(eval);