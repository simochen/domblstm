clear all;
fid = fopen('disc_seq.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    ds{i} = fgetl(fid);
    ds{i} = ds{i}(2:6);
    disc_seq{i} =  fgetl(fid);
    len(i) = length(disc_seq{i});
end
fclose(fid);

fid = fopen('disc_dom.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    dd{i} = fgetl(fid);
    dd{i} = dd{i}(2:8);
    disc_dom{i} =  fgetl(fid);
end
fclose(fid);

cnt = 0;
j = 1;
for i = 1:length(dd)
    if sum(dd{i}(1:5) ~= ds{j})
        seq_cnt(j) = cnt;
        j = j+1;
        cnt = 0;
    end
    cnt = cnt+1;
    if(cnt == 1)
        seq_poi(j) = i;
    end
    dom_poi(i) = j;
end
seq_cnt(length(ds)) = cnt;

save disc.mat ds dd disc_seq disc_dom len seq_poi seq_cnt dom_poi;