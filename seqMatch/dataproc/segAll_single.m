%function segAll_single(r, win, filename)
%USAGE: segment_all(10, 10, 'allseg.mat')
clear all
r = 10;
win = 10;
    load('../single1.mat')
    load('../data.mat')
    for i = 1: length(sd)
        single_X{i}(:,1:20) = single_X{i}(:,1:20)/20;
        single_y{i} = ones(len(i),1);
        single_y{i}(rg(i,1):rg(i,2)) = 0;
    end

    for i = 1: length(sd)
        seg{i} = 1:len(i);
        neigh{i} = zeros((2*win+1),length(seg{i}));
        n_X{i} = zeros((2*win+1),length(seg{i}),25);
        n_y{i} = zeros((2*win+1),length(seg{i}),1);
        for j = 1:2*win+1
            neigh{i}(j,:) = seg{i}+j-(win+1);
            for k = 1:length(seg{i})
                if ((neigh{i}(j,k) > 0) && (neigh{i}(j,k) <= len(i)))
                    n_X{i}(j,k,:) = single_X{i}(neigh{i}(j,k),:);
                    n_y{i}(j,k) = single_y{i}(neigh{i}(j,k));
                end
            end
        end
    end

    load('../sgroup5.mat')
    for i = 1: 5
        g_seg_X{i} = [];
        g_seg_y{i} = [];
        for j = 1: length(sg{i})
            g_seg_X{i} = [g_seg_X{i} n_X{sg{i}(j)}];
            g_seg_y{i} = [g_seg_y{i} n_y{sg{i}(j)}];
        end
    end
    
%    save(filename, 'single_y', 'g_seg_X', 'g_seg_y');
%end