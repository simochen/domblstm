clear all
load multi.mat
mlen = len;
reorder = randperm(720);
relen = mlen(reorder);
recnt = seq_cnt(reorder);
for i = 1:11
    for j = 1:5
        mm{i,j} = find((recnt==j+1) & (relen > (i-1)*100) & (relen <= i*100));
        mmlength(i,j) = length(mm{i,j}); 
    end
end
for k = 1:5
    mg{k} = [];
    for i = 2:8
        for j = 1:3
            mg{k} = [mg{k} mm{i,j}(1:floor(mmlength(i,j)/5))];
            mm{i,j} = mm{i,j}(floor(mmlength(i,j)/5)+1:end);
        end
    end
end

for j = 1:5
    m{j} = [];
    for i = 1:11
        m{j} = [m{j} mm{i,j}];
    end
    m{j} = m{j}(randperm(length(m{j})));
end

for i = 1:5
    for j = 1:5
        mg{i} = [mg{i} m{j}((i-1)*floor(length(m{j})/5)+1:i*floor(length(m{j})/5))];
    end
end

for i = 1:3
    mg{i} = [mg{i} m{2}(end+1-i) m{3}(end+1-i)];
end
mg{4} = [mg{4} m{1}(end-1) m{3}(end-3)];
mg{5} = [mg{5} m{1}(end) m{5}(end)];

for i = 1:5
    mg{i} = reorder(mg{i});
    meanlen(i) = mean(mlen(mg{i}));
end
meanlen

%save mgroup5.mat mg;