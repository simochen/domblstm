function obj = eval_calc(obj)
%USAGE: obj = eval_calc(obj)
%obj: [input]{tp, fp, fn} -> [output]{precision, recall, f1}
%obj: [input]{tp, fp, fn, tn} -> [output]{precision, recall, f1, mcc}
    obj.precision = obj.tp/(obj.tp+obj.fp);
	obj.recall = obj.tp/(obj.tp+obj.fn);
	obj.f1 = 2* obj.precision * obj.recall/(obj.precision+obj.recall);
    
    if isfield(obj, 'tn')
        obj.mcc = (obj.tp*obj.tn-obj.fp*obj.fn)/...
                   sqrt((obj.tp+obj.fp)*(obj.tp+obj.fn)*(obj.fp+obj.tn)*(obj.tn+obj.fn));
    end
end