%assign domain boundary without N- and C- terminal
clear all
load multi.mat
r = 5;
for i = 1:length(ms)
    multi_y{i} = zeros(length(multi_seq{i}),1);
    for j = 1:seq_cnt(i)-1
        left = range(seq_poi(i)+j-1,2) -r+1;
        right = range(seq_poi(i)+j,1) +r-1;
        multi_y{i}(left:right) = 1;
    end
    multi_y0{i} = multi_y{i};
    multi_y{i}(1:range(seq_poi(i),1)-1) = 1;
    multi_y{i}(range(seq_poi(i)+seq_cnt(i)-1,2)+1: len(i)) = 1;
end

save multi_data.mat multi_y multi_y0