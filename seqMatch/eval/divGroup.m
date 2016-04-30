clear all
load('../multi.mat')
load('../mgroup5.mat')

for i = 1:5 
    range_def{i} = [];
    sq_cnt{i} = [];
    sq_poi{i} = [];
    p = 1;
    for j = 1:length(mg{i})
        sq_cnt{i}(j) = seq_cnt(mg{i}(j));
        sq_poi{i}(j) = p;
        p = p + sq_cnt{i}(j);
        for k = 1:sq_cnt{i}(j)
            range_def{i} = [range_def{i}; range(seq_poi(mg{i}(j))+k-1,:)];
        end
    end
end
save mulgroup.mat range_def sq_cnt sq_poi mg