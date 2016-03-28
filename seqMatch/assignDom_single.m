clear all
load single.mat
for i = 1:length(ss)
    single_y{i} = ones(length(single_seq{i}),1);
    single_y{i}(range(i,1):range(i,2)) = 0;
end
save single_data.mat single_y