function n = boundaryMeasure(range_pred, range_def)
    n = 0;
    num_pred = size(range_pred, 1) - 1;
    num_def = size(range_def, 1) - 1;
    if((num_pred > 0) && (num_def > 0))
        for i = 1:num_pred
            for j = 1:num_def
                %mid_pred = range_pred(i,2);
                %mid_def = floor((range_def(j,2)+range_def(j+1,1))/2);
                bdr_pred = range_pred(i,2);
                %if(abs(mid_pred-mid_def) <= 20)
                if((bdr_pred-range_def(j,2) >= -20) && (bdr_pred-range_def(j+1,1) <= 20))
                    n = n+1;
                end
            end
        end
    end
end