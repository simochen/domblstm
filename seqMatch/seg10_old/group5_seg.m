clear all
load sgroup5.mat
load mgroup5.mat
load dgroup5.mat
load data.mat
load single_data.mat
load multi_data.mat
load segment10.mat

[single_X, mseg_X] = inputResize(single_X, mseg_X);
%[single_X, mseg_X] = inputNorm(single_X, mseg_X);
for j = 1:5
    for i = 1:620
        sg_X{i,j} = single_X{sg{j}(i)};
        sg_y{i,j} = single_y{sg{j}(i)};
    end
    for i = 1:144
        mg_seg_X{i,j} = mseg_X{mg{j}(i)};
        mg_seg_y{i,j} = mseg_y{mg{j}(i)};
        mg_seg_y0{i,j} = mseg_y0{mg{j}(i)};
    end
end

save group5_seg.mat mg mg_seg_X mg_seg_y mg_seg_y0;   