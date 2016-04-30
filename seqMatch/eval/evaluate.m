function [ptp,pfp,pfn,btp,bfp,bfn,ndo] = evaluate(s_cnt, s_poi, range_pred, seq_cnt, seq_poi, range_def)
    tpos = find(s_cnt == seq_cnt);
    t = length(tpos);
    trNum = t/length(seq_cnt);

    ptp = 0;
    nmul = 0;
    btp = 0;
    for i = 1:length(seq_cnt)
        if (s_cnt(i)>1)
            nmul = nmul+1;
        end
        pos_pred = s_poi(i);
        rg_pred = range_pred(pos_pred : pos_pred+ s_cnt(i) -1, :);
        pos_def = seq_poi(i);
        rg_def = range_def(pos_def : pos_def+ seq_cnt(i) -1, :);
        [n, ndo(i)] = domMeasure(rg_pred, rg_def);
        ptp = ptp + n;
        
        b = boundaryMeasure(rg_pred, rg_def);
        btp = btp + b;
    end
    pfp = size(range_pred,1) - ptp;
    pfn = size(range_def,1) - ptp;
    precision = ptp/size(range_pred,1);
    recall = ptp/size(range_def,1);
    f1 = 2*precision*recall/(precision+recall);
    
    bdr_pred = size(range_pred,1)-length(s_cnt);
    bdr_def = size(range_def,1)-length(seq_cnt);
    bfp = bdr_pred - btp;
    bfn = bdr_def - btp;
    bdr_prec = btp/bdr_pred;
    bdr_rc = btp/bdr_def;
    bdr_f1 = 2*bdr_prec*bdr_rc/(bdr_prec+bdr_rc);
    %fprintf('Specificiry: %.6f\tSensitivity: %.6f\n', Sp,Sn);
    fprintf('\n\n\n========== domain number (S/M) prediction ==========\n')
    fprintf('TP: %d\n',nmul);
    fprintf('\n============= domain number prediction =============\n')
    fprintf('T: %d\tTrue Number percentage: %.6f\n', t, trNum);
    fprintf('\n============ domain position prediction ============\n')
    fprintf('TP: %d\tFP: %d\tFN: %d\n',ptp, pfp, pfn);
    fprintf('precision: %.6f\trecall: %.6f\n', precision,recall);
    fprintf('F1 Score: %6f\n',f1);
    fprintf('\n============ domain boundary prediction ============\n')
    fprintf('TP: %d\tFP: %d\tFN: %d\n',btp, bfp, bfn);
    fprintf('precision: %.6f\trecall: %.6f\n', bdr_prec, bdr_rc);
    fprintf('F1 Score: %6f\n',bdr_f1);
    fprintf('\n=============== NDO score prediction ===============\n')
    fprintf('average NDO: %.6f\n', mean(ndo));
end