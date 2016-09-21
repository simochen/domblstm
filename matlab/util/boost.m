function boost_y = boost(dir, type, cv, mdNum)
%USAGE: boost_y = boost(dir, cv, mdNum)
    arr = [];
    for i = 1:numel(mdNum)
        basename = sprintf('../data/postproc/%s/hs10_w5_lr1e-01_cv%d_md%d', dir, cv, mdNum(i));
        if strcmp(type, 'single')
            filename = sprintf('%s_sg1.mat', basename);
        elseif strcmp(type, 'multi')
            filename = sprintf('%s.mat', basename);
        end
        load(filename);
        if i == 1
            boost_y = y * a;
        else
            boost_y = boost_y + y * a;
        end
        arr = [arr a];
    end
    boost_y = boost_y / sum(arr);
end