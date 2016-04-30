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

errlen = 4;
j = 1;
for i = 1:length(md)
    if sum(md{i}(1:5) ~= ms{j})
        j = j+1;
    end
    [range(i,1), range(i,2), overlap(i), cov(i)] = LCS(multi_seq{j}, multi_dom{i}, errlen);
    poi(i) = j;
end
