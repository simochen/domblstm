clear all;
for i = 1:720
    fname = sprintf('cullpdb/multi_f25/%d.txt',i);
    multi_X{i} = load(fname);
end

for i = 1:3100
    fname = sprintf('cullpdb/single_f25/%d.txt',i);
    single_X{i} = load(fname);
end

save data.mat single_X multi_X;