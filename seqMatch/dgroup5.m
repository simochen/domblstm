clear all
load disc.mat
dlen = len;
reorder = randperm(595);
relen = dlen(reorder);
recnt = seq_cnt(reorder);
for i = 1:10
    for j = 1:7
        d2{i,j} = find((recnt==j+1) & (relen > i*100) & (relen <= (i+1)*100));
        ddlength(i,j) = length(d2{i,j}); 
    end
end
for k = 1:5
    dg{k} = [];
    for i = 1:7
        for j = 1:3
            dg{k} = [dg{k} d2{i,j}(1:floor(ddlength(i,j)/5))];
            d2{i,j} = d2{i,j}(floor(ddlength(i,j)/5)+1:end);
        end
    end
end

for j = 1:7
    d{j} = [];
    for i = 1:10
        d{j} = [d{j} d2{i,j}];
    end
    d{j} = d{j}(randperm(length(d{j})));
end

for i = 1:5
    for j = 1:7
        dg{i} = [dg{i} d{j}((i-1)*floor(length(d{j})/5)+1:i*floor(length(d{j})/5))];
    end
end


dg{1} = [dg{1} d{1}(end) d{7}(end-1)];
dg{2} = [dg{2} d{2}(end-2) d{7}(end)];
dg{3} = [dg{3} d{2}(end-1) d{5}(end-2)];
dg{4} = [dg{4} d{2}(end) d{5}(end-1)];
dg{5} = [dg{5} d{4}(end) d{5}(end)];

for i = 1:5
    dg{i} = reorder(dg{i});
    meanlen(i) = mean(dlen(dg{i}));
end
meanlen

save dgroup5.mat dg;