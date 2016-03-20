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