clear all
addpath ../util
load('~/Code_Workspace/GDesign/casp11/multi_r20.mat');
opt = struct('win', 5, 'cutoff', [0.6, 0.65, 0.7], 'minBlen', 5, 'minArea', [0.1, 0.1, 0.1], 'minusArea', 0.01, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);
%opt = struct('win', 5, 'cutoff', [0.5, 0.5, 0.5], 'minBlen', 5, 'minArea', [2.5, 4.5, 4.5], 'minusArea', 0.01, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);
%opt = struct('win', 5, 'cutoff', [0.5, 0.5, 0.5], 'minBlen', 5, 'minArea', [0.1, 0.1, 0.1], 'minusArea', 0.01, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);

weight = 5;
dir = 'w5';
model = [1 2 3 4 5];
eval = struct('m', 0, 't', 0, 'ndo', [], ...
                  'dom', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'bdr', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'res', struct('tp', 0, 'fp', 0, 'fn', 0, 'tn', 0));
sg = 1;
for i = 1:5
    file = sprintf('../../model_pred/casp11/model%d_mul.mat', model(i));
    load(file);
    if i == 1
        yo = y;
    else
        yo = yo + y;
    end
end
yo = yo/5;
pred = postproc(yo, vec, opt);
for i = 1: numel(vec)
    def(i).label = vec(i).yi;
    def(i).range = vec(i).rangei;
    pred(i).label = pred(i).labelp;
end
meval = evaluate(pred, def);
eval_print(meval);
eval = meval;

load('~/Code_Workspace/GDesign/casp11/single.mat');

for i = 1:5
    file = sprintf('../../model_pred/casp11/model%d_sin.mat', model(i));
    load(file);
    if i == 1
        yo = y;
    else
        yo = yo + y;
    end
end
yo = yo/5;
spred = postproc(yo, vec, opt);
for i = 1: numel(vec)
    sdef(i).label = vec(i).yi;
    sdef(i).range = vec(i).rangei;
    spred(i).label = spred(i).labelp;
end
seval = evaluate(spred, sdef);
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