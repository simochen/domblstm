clear all
load('../data/process/mg_vec_r20.mat');
mvec = vec_group;
load('../data/process/sg_vec.mat');
svec = vec_group;
for i = 1:5
    mcell = struct2cell(mvec{i});
    mcell = mcell(4, 1, :);
    mlen = cell2mat(reshape(mcell,[],size(mcell,3)));
    scell = struct2cell(svec{i});
    scell = scell(4, 1, :);
    slen = cell2mat(reshape(scell,[],size(scell,3)));
    for j = 1:6
        leng_vec(i,j).mg = find(mlen > (j-1)*100 & mlen <= j*100);
        leng_vec(i,j).sg = find(slen > (j-1)*100 & slen <= j*100);
    end
    leng_vec(i,7).mg = find(mlen > 600);
    leng_vec(i,7).sg = find(slen > 600);
end

save('../data/process/len_group_vec.mat', 'leng_vec');