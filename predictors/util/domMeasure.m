function [n, ndo] = domMeasure(range_pred, range_def)
    n = 0;
    num_pred = size(range_pred, 1);
    num_def = size(range_def, 1);
    olp = zeros(num_pred, num_def);
    for i = 1:num_pred
        for j = 1:num_def
            if((abs(range_pred(i,1)-range_def(j,1)) <= 20) && (abs(range_pred(i,2)-range_def(j,2)) <= 20))
                n = n+1;
            end
            [olp(i,j),r] = overlap(range_pred(i,:),range_def(j,:));
        end
    end
    rscore = 2*max(olp,[],1)-sum(olp,1);
    cscore = 2*max(olp,[],2)-sum(olp,2);
    raw = (sum(rscore)+sum(cscore))/2;
    perf = sum(range_def(:,2)-range_def(:,1)+1);
    ndo = raw/perf;
end