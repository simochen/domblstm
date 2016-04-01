function [trNum, precision, recall, ndo] = evaluate(s_cnt, s_poi, range_pred, seq_cnt, seq_poi, range_def)
    tpos = find(s_cnt == seq_cnt);
    t = length(tpos);
    trNum = t/length(seq_cnt);

    tp = 0;
    for i = 1:length(seq_cnt)
        pos_pred = s_poi(i);
        rg_pred = range_pred(pos_pred : pos_pred+ s_cnt(i) -1, :);
        pos_def = seq_poi(i);
        rg_def = range_def(pos_def : pos_def+ seq_cnt(i) -1, :);
        [n, ndo(i)] = domMeasure(rg_pred, rg_def);
        tp = tp + n;
    end
    precision = tp/size(range_pred,1);
    recall = tp/size(range_def,1);
end