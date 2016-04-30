function [ptp,pfp,pfn,btp,bfp,bfn,ndo] = runEval_multi(cv, i)
    addpath ../postproc
    %log_hs10_b1000_cv5_ep7.mat
    
    filename = sprintf('log_hs10_b500_cv%d_i%d.mat', cv, i);
    postproc(10, 5, cv, filename)
    result(0.5, 20, 30, 40, 0)
    load pred.mat
    load boundary.mat
    load mulgroup.mat
    [ptp,pfp,pfn,btp,bfp,bfn,ndo] = evaluate(s_cnt, s_poi, range_pred, sq_cnt{cv}, sq_poi{cv}, range_def{cv});
end