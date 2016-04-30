clear all
load('../single.mat')
load('../sgroup5.mat')

for i = 1:5 
    range_def{i} = [];
    sq_cnt{i} = [];
    sq_poi{i} = [];
    for j = 1:length(sg{i})
        sq_cnt{i}(j) = 1;
        sq_poi{i}(j) = j;
        range_def{i} = [range_def{i}; range(sg{i}(j),:)];
    end
end
save singroup.mat range_def sq_cnt sq_poi sg