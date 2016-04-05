clear all
load sgroup5.mat
load mgroup5.mat
load dgroup5.mat
load data.mat
load single_data.mat
load multi_data.mat

[single_X, multi_X] = inputResize(single_X, multi_X);
%[single_X, multi_X] = inputNorm(single_X, multi_X);
for j = 1:5
    for i = 1:620
        sg_X{i,j} = single_X{sg{j}(i)};
        sg_y{i,j} = single_y{sg{j}(i)};
    end
    for i = 1:144
        mg_X{i,j} = multi_X{mg{j}(i)};
        mg_y{i,j} = multi_y{mg{j}(i)};
        mg_y0{i,j} = multi_y0{mg{j}(i)};
    end
end

save group5.mat sg mg dg sg_X sg_y mg_X mg_y mg_y0;   