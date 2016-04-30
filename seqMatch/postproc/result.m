function result(th, ter, tcb, cb, proc)
    load('pred.mat')
    if (proc == 1)
        proc_y = mean_y;
    else
        proc_y = win_y;
    end
    s_poi = zeros(1, length(proc_y));
    s_cnt = zeros(1, length(proc_y));
    range_pred = [];
    p = 1;
    for i = 1:length(proc_y)
        len = length(proc_y{i});
        bin_y{i} = zeros(1, len);
        boundary{i} = zeros(1, len);
        diff{i} = zeros(1, len);
        for j = 1: len
            if (proc_y{i}(j) >= th)
                bin_y{i}(j) = 1;
                boundary{i}(j) = proc_y{i}(j);
            end
            if (j == 1)
                diff{i}(j) = -1;
            else 
                diff{i}(j) = bin_y{i}(j) - bin_y{i}(j-1);
            end
        end
        s_poi(i) = p;
        bd = [];
        st = 0;
        for j = ter+1: len-ter
            if (diff{i}(j) == 1)
                st = j;
            end
            if (diff{i}(j) == -1)
                if (st~=0)
                    ed = j-1;
                    bd = [bd; [floor((st+ed)/2) ed-st+1]];
                end
            end
        end
        while(1)
            flag = 0;
            j = 1;
            while(j < size(bd,1))
                if (bd(j+1,1) - bd(j,1) < cb)
                    mc = bd(j,2)+bd(j+1,2);
                    mid = floor((bd(j+1,1)*bd(j+1,2)+bd(j,1)*bd(j,2))/mc);
                    bd = [bd(1:j-1,:); [mid mc]; bd(j+2:end,:)];
                    flag = 1;
                end
                j = j+1;
            end
            if(flag == 0)
                break;
            end
        end
        if size(bd,1) > 0
            if bd(1,1) <= tcb
                bd = bd(2:end,:);
            end
        end
        if size(bd,1) > 0
            if bd(end,1) > len-tcb
                bd = bd(1:end-1,:);
            end
        end
        bd = [[0 0]; bd; [len 0]];
        for j = 1: size(bd,1)-1
            range_pred = [range_pred; [bd(j,1)+1 bd(j+1,1)]];
        end
        s_cnt(i) = size(bd,1)-1;
        p = p + s_cnt(i);
    end
    save boundary.mat range_pred s_cnt s_poi;
end
            
    