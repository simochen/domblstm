function vec = load_feat(dir, r, obj, isSave)
%USAGE: vec = load_feat(dir, r, obj, isSave)
%vec -> {X, y, yi, len, range, rangei}
%example: mvec = load_feat('multi_f25', 20, multi, 1)
    for i = 1: numel(obj)
        file = sprintf('~/Code_Workspace/GDesign/casp11/%s/%d.txt', dir, i);
        vec(i).X = load(file);
        vec(i).X(:, 1:20) = vec(i).X(:, 1:20)/20;
        vec(i).yi = assign_label(obj(i).len, obj(i).range, r);
        vec(i).y = vec(i).yi;
        vec(i).y(1:obj(i).range(1,1)-1) = 1;
        vec(i).y(obj(i).range(end,2)+1:obj(i).len) = 1;
        
        vec(i).len = obj(i).len;
        vec(i).range = obj(i).range;
        vec(i).rangei = obj(i).rangei;
    end
    if isSave
        outfile = sprintf('~/Code_Workspace/GDesign/casp11/%s_r%d.mat', dir, r);
        save(outfile, 'vec');
    end
end