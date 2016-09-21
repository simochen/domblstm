function [common,olp] = overlap(range1, range2)
    %USAGE:[common,olp] = overlap(range1, range2)
    %range -> 1*2 double or []
    %if range = [], common = 0, olp = 0 
    if size(range1, 1) == 0 || size(range2, 1) == 0
        common = 0;
        olp = 0;
    else
        st1 = max([range1(1), range2(1)]);
        ed1 = min([range1(2), range2(2)]);
        st2 = min([range1(1), range2(1)]);
        ed2 = max([range1(2), range2(2)]);
        if(st1 <= ed1)
            common = ed1-st1+1;
        else
            common = 0;
        end
        union = ed2 - st2 +1;
        olp = common/union;
    end
end