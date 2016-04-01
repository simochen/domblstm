clear all;

fid = fopen('multi_dom.txt');
i = 0;
dpos = 0;
while ~feof(fid)
    i = i+1;
    fgetl(fid);
    line = fgetl(fid);
    ms_cnt(i) = str2double(line(30));
    for j = 1:ms_cnt(i)
        dpos = dpos + 1;
        if (j==1)
            ms_poi(i) =  dpos;
        end 
        line =  fgetl(fid);
        idx1 = strfind(line,':');
        idx2 = strfind(line,'-');
        md_poi(dpos) = i; 
        md_range(dpos,1) = str2double(line(idx1+2:idx2-2));
        md_range(dpos,2) = str2double(line(idx2+2:length(line)));
    end
end
fclose(fid);

save pred.mat ms_cnt ms_poi md_poi md_range;