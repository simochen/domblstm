function eval_print(eval)
    %USAGE: eval_print(eval)
    %eval -> {m,t,ndo,dom{tp,fp,fn},bdr{tp,fp,fn},res{tp,fp,fn,tn}}
    %eval.m -> #multi-domain seq
    %eval.t -> #true domain number
    eval.dom = eval_calc(eval.dom);
    eval.bdr = eval_calc(eval.bdr);
    eval.res = eval_calc(eval.res);
    
    fprintf('\n\n\n=============== prediction evaluation ===============\n');
    fprintf('\t\tTP\tFP\tTN\tprec.\t\trecall\t\tF1\t\tMCC\n');
    fprintf('residue\t%d\t%d\t%d\t%.6f\t%.6f\t%.6f\t%.6f\n', ...
            eval.res.tp, eval.res.fp, eval.res.fn, ...
            eval.res.precision, eval.res.recall, eval.res.f1, eval.res.mcc);
    fprintf('domain\t%d\t%d\t%d\t%.6f\t%.6f\t%.6f\n', ...
            eval.dom.tp, eval.dom.fp, eval.dom.fn, ...
            eval.dom.precision, eval.dom.recall, eval.dom.f1);
    fprintf('boundary\t%d\t%d\t%d\t%.6f\t%.6f\t%.6f\n', ...
            eval.bdr.tp, eval.bdr.fp, eval.bdr.fn, ...
            eval.bdr.precision, eval.bdr.recall, eval.bdr.f1);
    fprintf('mean NDO: %.6f\n', mean(eval.ndo));
    fprintf('#multi-domain seq: %d\t',eval.m);
    fprintf('#true domain number: %d\tpercentage: %.6f', eval.t, eval.t/numel(eval.ndo));
end