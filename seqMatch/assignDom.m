clear all
load multi.mat
r = 5;
for i = 1:length(ms)
    multi_y{i} = zeros(length(multi_seq{i}),1);
    for j = 1:seq_cnt(i)-1
        left = range_mdf(seq_poi(i)+j-1,2) -r+1;
        right = range_mdf(seq_poi(i)+j,1) +r-1;
        multi_y{i}(left:right) = 1;
    end
end
save multi_data.mat multi_y