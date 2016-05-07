clear all
load single.mat
slen = len;
reorder = randperm(3100);
relen = slen(reorder);
for i = 1:8
    s{i} = find((relen > (i-1)*100) & (relen <= i*100));
end
for i = 1:5
    sg{i} = [];
    for j = 1:6
        sg{i} = [sg{i} s{j}((i-1)*floor(length(s{j})/5)+1:i*floor(length(s{j})/5))];
    end
end
sg{1} = [sg{1} s{3}(end-1) s{5}(end-2) s{8}(end-2)];
sg{2} = [sg{2} s{3}(end) s{4}(end-3) s{8}(end-1)];
sg{3} = [sg{3} s{4}(end-2) s{6}(end) s{7}(end-1)];
sg{4} = [sg{4} s{4}(end-1) s{5}(end-1) s{7}(end)];
sg{5} = [sg{5} s{4}(end) s{5}(end) s{8}(end)];

for i = 1:5
    sg{i} = reorder(sg{i});
    meanlen(i) = mean(slen(sg{i}));
end
meanlen

save sgroup5.mat sg;