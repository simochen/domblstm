function [ptp,pfp,pfn,btp,bfp,bfn,ndo] = runEval_single(cv, i, sgp)
    addpath ../postproc
    %log_hs10_b1000_cv5_ep7.mat
    
    filename = sprintf('log_hs10_b500_cv%d_i%d_sg%d.mat', cv, i, sgp);
    postproc_single(10, 5, sgp, filename)
    result(0.5, 20, 30, 40, 0)
    load pred.mat
    load boundary.mat
    load singroup.mat
    [ptp,pfp,pfn,btp,bfp,bfn,ndo] = evaluate(s_cnt, s_poi, range_pred, sq_cnt{sgp}, sq_poi{sgp}, range_def{sgp});
end