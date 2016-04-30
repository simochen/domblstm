clear all
load('multi.mat')

for i = 1:length(ms)
    mseg{i} = [];
    n_term = range(seq_poi(i),1);
    if(n_term ~= 1)
        mseg{i} = [mseg{i}, 1: n_term+9];
    end
    for j = 1: seq_cnt(i)-1
        mseg{i} = [mseg{i}, range(seq_poi(i)+j-1,2)-14:range(seq_poi(i)+j,1)+14];
    end
    c_term = range(seq_poi(i)+seq_cnt(i)-1,2);
    if(c_term < len(i))
        mseg{i} = [mseg{i}, c_term-9 : len(i)];
    end
end

win = 5;
for i = 1:length(ms)
    mneigh{i} = zeros((2*win+1),length(mseg{i}));
    for j = 1:2*win+1
        mneigh{i}(j,:) = mseg{i}+j-(win+1);
    end
end

load('data.mat')
load('multi_data.mat')
for i = 1:length(ms)
    mseg_X{i} = zeros((2*win+1)*length(mseg{i}),25);
    mseg_y{i} = zeros((2*win+1)*length(mseg{i}),1);
    mseg_y0{i} = zeros((2*win+1)*length(mseg{i}),1);
    for j = 1:length(mseg{i})
        for k = 1:2*win+1
            if ((mneigh{i}(k,j) > 0) && (mneigh{i}(k,j) <= len(i)))
                mseg_X{i}((j-1)*(2*win+1)+k,:) = multi_X{i}(mneigh{i}(k,j),:);
                mseg_y{i}((j-1)*(2*win+1)+k,:) = multi_y{i}(mneigh{i}(k,j),:);
                mseg_y0{i}((j-1)*(2*win+1)+k,:) = multi_y0{i}(mneigh{i}(k,j),:);
            end
        end
    end
end
save segment10.mat mseg mneigh mseg_X mseg_y mseg_y0;