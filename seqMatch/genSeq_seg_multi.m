clear all;
fid = fopen('multi_seq.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    ms{i} = fgetl(fid);
    ms{i} = ms{i}(2:6);
    multi_seq{i} =  fgetl(fid);
    len(i) = length(multi_seq{i});
end
fclose(fid);

fid = fopen('multi_dom.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    md{i} = fgetl(fid);
    md{i} = md{i}(2:8);
    multi_dom{i} =  fgetl(fid);
end
fclose(fid);

errlen = 3;
j = 1;
olp = ones(1595,2);
cov = ones(1595,2);
cnt = 0;
for i = 1:length(md)
    if sum(md{i}(1:5) ~= ms{j})
        seq_cnt(j) = cnt;
        j = j+1;
        cnt = 0;
    end
    cnt = cnt+1;
    if(cnt == 1)
        seq_poi(j) = i;
    end
    dom_poi(i) = j;
    dlen = length(multi_dom{i});
    if dlen < 90
        [range(i,1), range(i,2), olp(i,1), cov(i,1)] = LCS(multi_seq{j}, multi_dom{i}, errlen);
    else
        num = 3;
        [range(i,1), mid, olp(i,1), cov(i,1)] = LCS(multi_seq{j}, multi_dom{i}(1:floor(dlen/num)), errlen);
        [mid, range(i,2), olp(i,2), cov(i,2)] = LCS(multi_seq{j}, multi_dom{i}(dlen-floor(dlen/num):dlen), errlen);
    end
end
seq_cnt(length(ms)) = cnt;
%save multi.mat ms md range multi_seq multi_dom seq_cnt seq_poi dom_poi len;