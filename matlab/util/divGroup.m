function vec_group = divGroup(vec, group, isSave, basename)
%USAGE: vec_group = divGroup(vec, group, isSave, basename)
%example: mg_vec = divGroup(mvec, mg, 1, 'mg_vec_r20')
%         sg_vec = divGroup(svec, sg, 1, 'sg_vec')
    for i = 1:numel(group)
        vec_group(i) = {vec(group{i})};
    end
    if isSave
        outfile = sprintf('../data/process/%s.mat', basename);
        save(outfile, 'vec_group');
    end
end