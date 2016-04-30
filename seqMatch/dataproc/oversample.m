function oversample(w, isRand, filename)
%USAGE: oversample(10, 1, 'w10.mat')
load('../r20/pos.mat')
mg_seg_X1 = mg_seg_X;
mg_seg_y1 = mg_seg_y;
mg_seg_y01 = mg_seg_y0;

load('../r20/allseg.mat')
num = 0;
den = 0;
for i = 1:5
    for j = 1:w
        mg_seg_X{i} = [mg_seg_X{i} mg_seg_X1{i}];
        mg_seg_y{i} = [mg_seg_y{i} mg_seg_y1{i}];
        mg_seg_y0{i} = [mg_seg_y0{i} mg_seg_y01{i}];
        
        if(isRand)
            reorder = randperm(size(mg_seg_X{i},2));
            mg_seg_X{i} = mg_seg_X{i}(:,reorder,:);
            mg_seg_y{i} = mg_seg_y{i}(:,reorder,:);
            mg_seg_y0{i} = mg_seg_y0{i}(:,reorder,:);
        end
    end  
    
    num = num + sum(sum(mg_seg_y{i}));
    den = den + numel(mg_seg_y{i});
end

num
den
per = num / den

save(filename, 'mg_seg_X', 'mg_seg_y', 'mg_seg_y0');
end