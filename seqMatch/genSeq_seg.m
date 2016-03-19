clear all;
fid = fopen('multi_seq.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    ms{i} = fgetl(fid);
    ms{i} = ms{i}(2:6);
    multi_seq{i} =  fgetl(fid);
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
for i = 1:length(md)
    if sum(md{i}(1:5) ~= ms{j})
        j = j+1;
    end
    poi(i) = j;
    len = length(multi_dom{i});
    if len < 90
        [range(i,1), range(i,2), olp(i,1), cov(i,1)] = LCS(multi_seq{j}, multi_dom{i}, errlen);
    else
        num = 3;
        [range(i,1), mid, olp(i,1), cov(i,1)] = LCS(multi_seq{j}, multi_dom{i}(1:floor(len/num)), errlen);
        [mid, range(i,2), olp(i,2), cov(i,2)] = LCS(multi_seq{j}, multi_dom{i}(len-floor(len/num):len), errlen);
    end
end
