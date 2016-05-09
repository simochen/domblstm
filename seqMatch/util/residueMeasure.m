function resM = residueMeasure(label_pred, label_def)
    %USAGE: resM = residueMeasure(label_pred, label_def)
    %resM -> {tp, fp, fn, tn}
    resM = struct('tp', 0, 'fp', 0, 'fn', 0, 'tn', 0);
    for i = 1: numel(label_pred)
        if (label_pred(i))
            if (label_def(i))
                resM.tp = resM.tp + 1;
            else
                resM.fp = resM.fp + 1;
            end
        else
            if (label_def(i))
                resM.fn = resM.fn + 1;
            else
                resM.tn = resM.tn + 1;
            end
        end
    end
end