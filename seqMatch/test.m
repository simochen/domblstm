load multi_data.mat
load data.mat

sall = [];
for i = 1:length(single_X)
%    sall = [sall; single_X{i}];
end
mall = [];
for i = 1:length(multi_X)
%    mall = [mall; multi_X{i}];
    r(i) = sum(multi_y{i})/(length(multi_y{i}));
end

