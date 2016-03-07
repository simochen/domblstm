fid = fopen('multi354_target.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    multi_y{i} =  fgetl(fid)';
end
fclose(fid);


fid = fopen('single963_target.txt');
i = 0;
while ~feof(fid)
    i = i+1;
    single_y{i} =  fgetl(fid)';
end
fclose(fid);

for i = 1:354
    fname = sprintf('multi_s8a20/%d.txt',i);
    multi_X{i} = load(fname);
end

for i = 1:963
    fname = sprintf('single_s8a20/%d.txt',i);
    single_X{i} = load(fname);
end