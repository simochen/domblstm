clear all;
load multi.mat;
range_mdf = range;
flag = zeros(length(ms),1);
for i = 1:length(ms)
    [range_mdf(seq_poi(i):seq_poi(i)+seq_cnt(i)-1,:),I] = sort(range(seq_poi(i):seq_poi(i)+seq_cnt(i)-1,:),1);
    range_mdf(seq_poi(i),1) = 1;
    range_mdf(seq_poi(i)+seq_cnt(i)-1,2) = length(multi_seq{i});
    if(sum(I(:,1)~=I(:,2)))
        flag(i) = 1;
    end
end
save multi.mat ms md range multi_seq multi_dom seq_cnt seq_poi dom_poi range_mdf;