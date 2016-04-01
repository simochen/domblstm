clear all;
load multi.mat;
flag = zeros(length(ms),1);
for i = 1:length(ms)
    [range(seq_poi(i):seq_poi(i)+seq_cnt(i)-1,:),I] = sort(range(seq_poi(i):seq_poi(i)+seq_cnt(i)-1,:),1);
    if(sum(I(:,1)~=I(:,2)))
        flag(i) = 1;
    end
end
range_mdf = range;
for i = 1:length(ms)
    range_mdf(seq_poi(i),1) = 1;
    range_mdf(seq_poi(i)+seq_cnt(i)-1,2) = length(multi_seq{i});
end
save multi.mat ms md range len multi_seq multi_dom seq_cnt seq_poi dom_poi range_mdf;