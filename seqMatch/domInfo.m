clear all
load multi.mat
domlen = range(:,2)-range(:,1)+1;
domlen_mdf = range_mdf(:,2)-range_mdf(:,1)+1;
a = find(domlen < 40);

b = find(domlen_mdf < 40);
c = [];
for i = 1 :length(b)
    if range_mdf(b(i),1) ~= 1
        c = [c b(i)];
    end
end

linker = [];
for i = 1:length(ms)
    for j = 1:seq_cnt(i)-1
        left = range_mdf(seq_poi(i)+j-1,2);
        right = range_mdf(seq_poi(i)+j,1);
        linker = [linker right-left];
    end
end