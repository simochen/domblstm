clear all;
fid = fopen('single_seq.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    ss{i} = fgetl(fid);
    ss{i} = ss{i}(2:6);
    single_seq{i} =  fgetl(fid);
end
fclose(fid);

fid = fopen('single_dom_1.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    sd{i} = fgetl(fid);
    sd{i} = sd{i}(2:8);
    single_dom{i} =  fgetl(fid);
end
fclose(fid);

errlen = 3;
olp = ones(3100,2);
cov = ones(3100,2);
len_seq = zeros(length(ss),1);
for i = 1:length(sd)
    len = length(single_dom{i});
    len_seq(i) = length(single_seq{i});
    if len < 60
        [range(i,1), range(i,2), olp(i,1), cov(i,1)] = LCS(single_seq{i}, single_dom{i}, errlen);
    else
        num = 3;
        [rg(1,1), mid, olp(i,1), cov(i,1)] = LCS(single_seq{i}, single_dom{i}(1:floor(len/num)), errlen);
        [mid, rg(1,2), olp(i,2), cov(i,2)] = LCS(single_seq{i}, single_dom{i}(len-floor(len/num):len), errlen);
        [rg(2,1), mid, olp(i,1), cov(i,1)] = LCS(single_seq{i}, single_dom{i}(1:20), errlen);
        [mid, rg(2,2), olp(i,2), cov(i,2)] = LCS(single_seq{i}, single_dom{i}(len-20:len), errlen);
        range(i,1) = min(rg(:,1));
        range(i,2) = max(rg(:,2));
    end
end

p = find(range(:,1)<=3);
range(p,1) = 1;
q = find(len_seq-range(:,2)==1);
range(q,2) = len_seq(q);
save single.mat ss sd range single_seq single_dom;