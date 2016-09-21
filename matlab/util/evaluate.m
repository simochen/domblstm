function eval = evaluate(pred, def)
    %USAGE: eval = evaluate(pred, def)
    %pred -> {y, label, range}
    %def -> {label, range}
    %[def need to be pre-defined]
    %[eg. for i = 1:numel(vec{2})
    %         def(i).label = vec{2}(i).yi;
    %         def(i).range = vec{2}(i).rangei;
    %     end]
    %eval -> {m,t,ndo,dom{tp,fp,fn},bdr{tp,fp,fn},res{tp,fp,fn,tn}}
    %eval.m -> #multi-domain seq
    %eval.t -> #true domain number
    eval = struct('m', 0, 't', 0, 'ndo', [], ...
                  'dom', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'bdr', struct('tp', 0, 'fp', 0, 'fn', 0), ...
                  'res', struct('tp', 0, 'fp', 0, 'fn', 0, 'tn', 0));
    
    for i = 1:numel(pred)
        if size(pred(i).range, 1) > 1
            eval.m = eval.m + 1;
        end
        if size(pred(i).range, 1) == size(def(i).range, 1)
            eval.t =eval.t + 1;
        end
        
        dom = domMeasure(pred(i).range, def(i).range);
        eval.ndo = [eval.ndo dom.ndo];
        eval.dom.tp = eval.dom.tp + dom.tp;
        eval.dom.fp = eval.dom.fp + dom.fp;
        eval.dom.fn = eval.dom.fn + dom.fn;
        
        bdr = boundaryMeasure(pred(i).range, def(i).range);
        eval.bdr.tp = eval.bdr.tp + bdr.tp;
        eval.bdr.fp = eval.bdr.fp + bdr.fp;
        eval.bdr.fn = eval.bdr.fn + bdr.fn;
        
        res = residueMeasure(pred(i).label, def(i).label);
        eval.res.tp = eval.res.tp + res.tp;
        eval.res.fp = eval.res.fp + res.fp;
        eval.res.fn = eval.res.fn + res.fn;
        eval.res.tn = eval.res.tn + res.tn;
    end
end