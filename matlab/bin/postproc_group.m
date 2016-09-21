clear all
addpath ../util
load('../data/process/mg_vec_r20.mat');     %vec_group
load('../data/process/len_group_vec.mat');  %leng_vec
opt = struct('win', 5, 'cutoff', [0.5,0.5,0.5], 'minBlen', 5, 'minArea', [0.5, 0.1, 0.1], 'minusArea', 0, 'skip', 20, 'termComb', 30, 'inComb', 40, 'isShow', 0, 'pauseTime', -1);

model_arg = [122 142 297 447 472];
eval = struct('m', 0, 't', 0, 'ndo', [], ...
                  'dom', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'bdr', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'res', struct('tp', 0, 'fp', 0, 'fn', 0, 'tn', 0));
sg = 1;
lg = 1;
for k = 1:5
    param(k).cv = k;
    param(k).ep = model_arg(k);
    file = sprintf('../data/postproc/w5/log_hs10_w5_cv%d_ep%d.mat', param(k).cv, param(k).ep); %y
    load(file)
    pred = postproc(y, vec_group{param(k).cv}, opt);
    sub_vec = vec_group{param(k).cv}(leng_vec(param(k).cv,lg).mg);
    sub_pred = pred(leng_vec(param(k).cv,lg).mg);
    %post_plot(sub_pred, sub_vec, opt);
    for i = 1: numel(sub_vec)
        sub_def(i).label = sub_vec(i).yi;
        sub_def(i).range = sub_vec(i).rangei;
    end
    meval = evaluate(sub_pred, sub_def);
    eval.m = eval.m + meval.m;
    eval.t = eval.t + meval.t;
    eval.ndo = [eval.ndo, meval.ndo];
    eval.dom.tp = eval.dom.tp + meval.dom.tp;
    eval.dom.fp = eval.dom.fp + meval.dom.fp;
    eval.dom.fn = eval.dom.fn + meval.dom.fn;
    eval.bdr.tp = eval.bdr.tp + meval.bdr.tp;
    eval.bdr.fp = eval.bdr.fp + meval.bdr.fp;
    eval.bdr.fn = eval.bdr.fn + meval.bdr.fn;
    eval.res.tp = eval.res.tp + meval.res.tp;
    eval.res.fp = eval.res.fp + meval.res.fp;
    eval.res.fn = eval.res.fn + meval.res.fn;
    eval.res.tn = eval.res.tn + meval.res.tn;
end
eval_print(eval);

load('../data/process/sg_vec.mat');

for i = 1:5
    file = sprintf('../data/postproc/w5/log_hs10_w5_cv%d_ep%d_sg%d.mat', param(i).cv, param(i).ep, sg);
    load(file)
    if i == 1
        yo = y;
    else
        yo = yo + y;
    end
end
yo = yo/5;
pred = postproc(yo, vec_group{sg}, opt);
sub_vec = vec_group{sg}(leng_vec(sg,lg).sg);
sub_pred = pred(leng_vec(sg,lg).sg);
%post_plot(sub_pred, sub_vec, opt);
for i = 1: numel(sub_vec)
    sub_def(i).label = sub_vec(i).yi;
    sub_def(i).range = sub_vec(i).rangei;
end
seval = evaluate(sub_pred, sub_def);
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