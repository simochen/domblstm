function segment_all(r, win, filename)
%USAGE: segment_all(10, 10, 'allseg.mat')
    load('../multi1.mat')
    load('../data.mat')
    for i = 1:length(ms)
        multi_X{i}(:,1:20) = multi_X{i}(:,1:20)/20;
        multi_y{i} = zeros(length(multi_seq{i}),1);
        for j = 1:seq_cnt(i)-1
            left = rg(seq_poi(i)+j-1,2) -r+1;
            right = rg(seq_poi(i)+j,1) +r-1;
            multi_y{i}(left:right) = 1;
        end
        multi_y0{i} = multi_y{i};
        multi_y{i}(1:rg(seq_poi(i),1)-1) = 1;
        multi_y{i}(rg(seq_poi(i)+seq_cnt(i)-1,2)+1: len(i)) = 1;
    end

    for i = 1:length(ms)
        mseg{i} = 1:len(i);
        mneigh{i} = zeros((2*win+1),length(mseg{i}));
        mn_X{i} = zeros((2*win+1),length(mseg{i}),25);
        mn_y{i} = zeros((2*win+1),length(mseg{i}),1);
        mn_y0{i} = zeros((2*win+1),length(mseg{i}),1);
        for j = 1:2*win+1
            mneigh{i}(j,:) = mseg{i}+j-(win+1);
            for k = 1:length(mseg{i})
                if ((mneigh{i}(j,k) > 0) && (mneigh{i}(j,k) <= len(i)))
                    mn_X{i}(j,k,:) = multi_X{i}(mneigh{i}(j,k),:);
                    mn_y{i}(j,k) = multi_y{i}(mneigh{i}(j,k));
                    mn_y0{i}(j,k) = multi_y0{i}(mneigh{i}(j,k));
                end
            end
        end
    end
    
    load('../mgroup5.mat')
    for i = 1: 5
        mg_seg_X{i} = [];
        mg_seg_y{i} = [];
        mg_seg_y0{i} = [];
        for j = 1: 144
            mg_seg_X{i} = [mg_seg_X{i} mn_X{mg{i}(j)}];
            mg_seg_y{i} = [mg_seg_y{i} mn_y{mg{i}(j)}];
            mg_seg_y0{i} = [mg_seg_y0{i} mn_y0{mg{i}(j)}];
        end
    end
    
    save(filename, 'multi_y', 'multi_y0', 'mg_seg_X', 'mg_seg_y', 'mg_seg_y0');
end