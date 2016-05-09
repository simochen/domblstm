clear all
addpath ../util
load('../data/process/mg_vec_r20.mat');
opt = struct('win', 5, 'cutoff', 0.65, 'minBlen', 5, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);
param.cv = 2;
param.ep = 86;
param.sg = 1;
file = sprintf('../data/postproc/log_hs10_w5_cv%d_ep%d.mat', param.cv, param.ep);
load(file)
pred = postproc(y, vec_group{param.cv}, opt);
for i = 1: numel(vec_group{param.cv})
    def(i).y = vec_group{param.cv}(i).yi;
    def(i).range = vec_group{param.cv}(i).rangei;
end
meval = evaluate(pred, def);
eval_print(meval);

load('../data/process/sg_vec.mat');
file = sprintf('../data/postproc/log_hs10_w5_cv%d_ep%d_sg%d.mat', param.cv, param.ep, param.sg);
load(file)
pred = postproc(y, vec_group{param.sg}, opt);
for i = 1: numel(vec_group{param.sg})
    def(i).y = vec_group{param.sg}(i).yi;
    def(i).range = vec_group{param.sg}(i).rangei;
end
seval = evaluate(pred, def);
eval_print(seval);

eval.m = meval.m + seval.m/5;
eval.t = meval.t + seval.t/5;
sndo = seval.ndo(randperm(620));
eval.ndo = [meval.ndo, sndo(1:124)];
eval.dom.tp = round(meval.dom.tp + seval.dom.tp/5);
eval.dom.fp = round(meval.dom.fp + seval.dom.fp/5);
eval.dom.fn = round(meval.dom.fn + seval.dom.fn/5);
eval.bdr.tp = round(meval.bdr.tp + seval.bdr.tp/5);
eval.bdr.fp = round(meval.bdr.fp + seval.bdr.fp/5);
eval.bdr.fn = round(meval.bdr.fn + seval.bdr.fn/5);
eval.res.tp = round(meval.res.tp + seval.res.tp/5);
eval.res.fp = round(meval.res.fp + seval.res.fp/5);
eval.res.fn = round(meval.res.fn + seval.res.fn/5);
eval.res.tn = round(meval.res.tn + seval.res.tn/5);
eval_print(eval);