clear all
addpath ../util
load('~/Code_Workspace/GDesign/casp11/multi_r20.mat');
%opt = struct('win', 5, 'cutoff', [0.6, 0.65, 0.7], 'minBlen', 5, 'minArea', [0.1, 0.1, 0.1], 'minusArea', 0, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);
%opt = struct('win', 5, 'cutoff', [0.5, 0.5, 0.5], 'minBlen', 5, 'minArea', [2.5, 4.5, 4.5], 'minusArea', 0, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);
opt = struct('win', 5, 'cutoff', [0.5, 0.5, 0.5], 'minBlen', 5, 'minArea', [0.1, 0.1, 0.1], 'minusArea', 0, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);

weight = 5;
dir = 'w5';
model_arg = [122 142 229 447 472];
eval = struct('m', 0, 't', 0, 'ndo', [], ...
                  'dom', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'bdr', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'res', struct('tp', 0, 'fp', 0, 'fn', 0, 'tn', 0));

k = 6;
file = sprintf('../../model_pred/casp11/model%d_mul.mat', k);
load(file);
    
pred = postproc(y, vec, opt);
for i = 1: numel(vec)
    def(i).label = vec(i).yi;
    def(i).range = vec(i).rangei;
end
meval = evaluate(pred, def);
eval_print(meval);
eval = meval;

load('~/Code_Workspace/GDesign/casp11/single.mat');

k = 1;
file = sprintf('../../model_pred/casp11/model%d_sin.mat', k);
load(file);
pred = postproc(y, vec, opt);
for i = 1: numel(vec)
    def(i).label = vec(i).yi;
    def(i).range = vec(i).range;
end
seval = evaluate(pred, def);
eval_print(seval);

    eval.m = eval.m + seval.m;
    eval.t = eval.t + seval.t;
    eval.ndo = [eval.ndo, seval.ndo];
    eval.dom.tp = eval.dom.tp + seval.dom.tp;
    eval.dom.fp = eval.dom.fp + seval.dom.fp;
    eval.dom.fn = eval.dom.fn + seval.dom.fn;
    eval.bdr.tp = eval.bdr.tp + seval.bdr.tp;
    eval.bdr.fp = eval.bdr.fp + seval.bdr.fp;
    eval.bdr.fn = eval.bdr.fn + seval.bdr.fn;
    eval.res.tp = eval.res.tp + seval.res.tp;
    eval.res.fp = eval.res.fp + seval.res.fp;
    eval.res.fn = eval.res.fn + seval.res.fn;
    eval.res.tn = eval.res.tn + seval.res.tn;
eval_print(eval);