function domM = domMeasure(range_pred, range_def)
    %USAGE: domM = domMeasure(range_pred, range_def)
    %range( of a protein ) -> n*2 double, n > 0
    %domM -> {tp, fp, fn, ndo}
    domM.tp = 0;
    num_pred = size(range_pred, 1);
    num_def = size(range_def, 1);
    olp = zeros(num_pred, num_def);
    linker_pred = getLinker(range_pred);
    linker_def = getLinker(range_def);
    
    for i = 1:num_pred
        for j = 1:num_def
            if((abs(range_pred(i,1)-range_def(j,1)) <= 20) && (abs(range_pred(i,2)-range_def(j,2)) <= 20))
                domM.tp = domM.tp+1;
            end
            [olp(i,j),~] = overlap(range_pred(i,:),range_def(j,:));
        end
    end
    linker_pred_olp = linker_overlap(linker_pred, range_def);
    linker_def_olp = linker_overlap(linker_def, range_pred);
    olp = [[0, linker_pred_olp]; [linker_def_olp', olp]];
    
    rscore = 2*max(olp,[],1)-sum(olp,1);
    rscore = rscore(2:end);
    cscore = 2*max(olp,[],2)-sum(olp,2);
    cscore = cscore(2:end);
    raw = (sum(rscore)+sum(cscore))/2;
    perf = sum(range_def(:,2)-range_def(:,1)+1);
    domM.ndo = raw/perf;
    
    domM.fp = num_pred - domM.tp;
    domM.fn = num_def - domM.tp;
end