function runEval(cv, i, sgp)

[mptp,mpfp,mpfn,mbtp,mbfp,mbfn,mndo] = runEval_multi(cv, i);
[sptp,spfp,spfn,sbtp,sbfp,sbfn,sndo] = runEval_single(cv, i, sgp);

ptp = mptp+sptp/5;
pfp = mpfp+spfp/5;
pfn = mpfn+spfn/5;
btp = mbtp+sbtp/5;
bfp = mbfp+sbfp/5;
bfn = mbfn+sbfn/5;
ndo = (sum(mndo)+sum(sndo)/5)/(numel(mndo)+numel(sndo)/5);

    precision = ptp/(ptp+pfp);
    recall = ptp/(ptp+pfn);
    f1 = 2*precision*recall/(precision+recall);
    
    bdr_prec = btp/(btp+bfp);
    bdr_rc = btp/(btp+bfn);
    bdr_f1 = 2*bdr_prec*bdr_rc/(bdr_prec+bdr_rc);

    fprintf('\n\n\n============ domain position prediction ============\n')
    fprintf('TP: %d\tFP: %d\tFN: %d\n',ptp, pfp, pfn);
    fprintf('precision: %.6f\trecall: %.6f\n', precision,recall);
    fprintf('F1 Score: %6f\n',f1);
    fprintf('\n============ domain boundary prediction ============\n')
    fprintf('TP: %d\tFP: %d\tFN: %d\n',btp, bfp, bfn);
    fprintf('precision: %.6f\trecall: %.6f\n', bdr_prec, bdr_rc);
    fprintf('F1 Score: %6f\n',bdr_f1);
    fprintf('\n=============== NDO score prediction ===============\n')
    fprintf('average NDO: %.6f\n', ndo);
end