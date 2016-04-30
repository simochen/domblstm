clear all;

fid = fopen('multi_res.txt');
i = 0;
dpos = 1;
while ~feof(fid)
    i = i+1;
    fgetl(fid);
    line = fgetl(fid);
    ms_poi(i) = dpos;
    idx1 = strfind(line,'(');
    idx2 = strfind(line,'-');
    idx3 = strfind(line,')');
    ms_cnt(i) = length(idx1);
    for j = 1:ms_cnt(i)
        md_poi(dpos) = i;
        md_range(dpos,1) = str2double(line(idx1(j)+1:idx2(j)-1));
        md_range(dpos,2) = str2double(line(idx2(j)+1:idx3(j)-1));
        dpos = dpos+1;
    end
end
fclose(fid);

fid = fopen('single_res.txt');
i = 0;
dpos = 1;
while ~feof(fid)
    i = i+1;
    fgetl(fid);
    line = fgetl(fid);
    ss_poi(i) = dpos;
    idx1 = strfind(line,'(');
    idx2 = strfind(line,'-');
    idx3 = strfind(line,')');
    ss_cnt(i) = length(idx1);
    for j = 1:ss_cnt(i)
        sd_poi(dpos) = i;
        sd_range(dpos,1) = str2double(line(idx1(j)+1:idx2(j)-1));
        sd_range(dpos,2) = str2double(line(idx2(j)+1:idx3(j)-1));
        dpos = dpos+1;
    end
end
fclose(fid);

save pred.mat ms_cnt ms_poi md_poi md_range ss_cnt ss_poi sd_poi sd_range;