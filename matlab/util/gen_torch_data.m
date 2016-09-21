function gen_torch_data(svec, mvec, savefile)
%USAGE: gen_torch_data(svec, mvec, savefile)
%vec -> {X, y, yi, len, range, rangei}
%example: gen_torch_data(svec, mvec, 'testset.mat')
    for i = 1:numel(svec)
        sX{i} = svec(i).X;
        sy{i} = svec(i).y';
        syi{i} = svec(i).yi';
    end
    for i = 1:numel(mvec)
        mX{i} = mvec(i).X;
        my{i} = mvec(i).y';
        myi{i} = mvec(i).yi';
    end
    save(savefile, 'sX', 'sy', 'syi', 'mX', 'my', 'myi');
end