function [common,olp] = overlap(range_pred, range_def)
    st1 = max([range_pred(1), range_def(1)]);
    ed1 = min([range_pred(2), range_def(2)]);
    st2 = min([range_pred(1), range_def(1)]);
    ed2 = max([range_pred(1), range_def(1)]);
    if(st1 < ed1)
        common = ed1-st1;
    else
        common = 0;
    end
    union = ed2 - st2;
    olp = common/union;
end