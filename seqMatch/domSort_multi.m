clear all;
load multi.mat;
flag = zeros(length(ms),1);
for i = 1:length(ms)
    [range(seq_poi(i):seq_poi(i)+seq_cnt(i)-1,:),I] = sort(range(seq_poi(i):seq_poi(i)+seq_cnt(i)-1,:),1);
    if(sum(I(:,1)~=I(:,2)))
        flag(i) = 1;
    end
end

p = find(range(seq_poi,1)<=3);
range(seq_poi(p),1) = 1;
q = find(len'-range(seq_poi+seq_cnt-1,2)<=2);
range(seq_poi(q)+seq_cnt(q)-1,2) = len(q)';

range_mdf = range;
for i = 1:length(ms)
    range_mdf(seq_poi(i),1) = 1;
    range_mdf(seq_poi(i)+seq_cnt(i)-1,2) = length(multi_seq{i});
end
save multi.mat ms md range len multi_seq multi_dom seq_cnt seq_poi dom_poi range_mdf;