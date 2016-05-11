addpath ../../../seqMatch/util
load ../../../seqMatch/data/process/multi_vec_r20.mat
load ../dataproc/multi_pred.mat
for i = 1:numel(vec)
    def(i).label = vec(i).yi;
    def(i).range = vec(i).rangei;
end
meval = evaluate(pred, def);
eval_print(meval);

g = 1;
load ../../../seqMatch/data/process/sg_vec.mat
load ../../../seqMatch/data/process/sgroup5.mat
load ../dataproc/single_pred.mat
for i = 1:numel(vec_group{g})
    def(i).label = vec_group{g}(i).yi;
    def(i).range = vec_group{g}(i).rangei;
end
for i = 1:numel(sg{g})
    sub_pred(i).label = pred(sg{g}(i)).label;
    sub_pred(i).range = pred(sg{g}(i)).range;
end
seval = evaluate(sub_pred, def);
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