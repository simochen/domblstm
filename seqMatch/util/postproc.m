function pred = postproc(raw_y, sub_vec, opt)
%USAGE: pred = postproc(raw_y, sub_vec, opt)
%raw_y -> raw output of torch
%sub_vec -> 1 cell of vec_group {X, y, yi, len, range, rangei}
%opt -> {win, cutoff, minBlen, skip, inComb, termComb, isShow, pauseTime}
%pred -> {y, label, range}
    p = 1;
    for i = 1: numel(sub_vec)
        y = raw_y(p:p+sub_vec(i).len-1);
        p = p+sub_vec(i).len;
        pred(i).y = winSmooth(y, opt.win);
        
        pred(i).label = (pred(i).y >= opt.cutoff);
        diff = zeros(1, sub_vec(i).len);
        diff(1) = -1;
        for j = 2: sub_vec(i).len
            diff(j) = pred(i).label(j)-pred(i).label(j-1);
        end
        
        pred(i).range = [];
        bdr = [];
        bnum = [];
        st = 0;
        ed = sub_vec(i).len;
        for j = opt.skip+1: sub_vec(i).len-opt.skip
            if (diff(j) == 1)
                st = j;
            end
            if (diff(j) == -1)
                if st ~= 0
                    ed = j-1;
                    num = ed-st+1;
                    if num >= opt.minBlen
                        bdr = [bdr, floor((st+ed)/2)];
                        bnum = [bnum, num];
                    end
                end
            end
        end
        while(1)
            flag = 0;
            j = 1;
            while (j < numel(bdr))
                if bdr(j+1)-bdr(j) < opt.inComb
                    num = bnum(j)+bnum(j+1);
                    mid = floor((bdr(j)*bnum(j)+bdr(j+1)*bnum(j+1))/num);
                    bdr = [bdr(1:j-1) mid bdr(j+2:end)];
                    bnum = [bnum(1:j-1) num bnum(j+2:end)];
                    flag = 1;
                end
                j = j+1;
            end
            if (flag == 0)
                break;
            end
        end
        if (numel(bdr) > 0)
            if (bdr(1) <= opt.termComb)
                bdr = bdr(2:end);
            end
        end
        if (numel(bdr) > 0)
            if (bdr(end) > sub_vec(i).len-opt.termComb)
                bdr = bdr(1:end-1);
            end
        end
        bdr = [0, bdr, sub_vec(i).len];
        for j = 1: numel(bdr)-1
            pred(i).range = [pred(i).range; [bdr(j)+1 bdr(j+1)]];
        end
        if (opt.isShow)
            x = 1: sub_vec(i).len;
            plot(x, sub_vec(i).yi, x, pred(i).y);
            str = sprintf('Prediction of sequence: %d', i);
            title(str);
            hold on;
            plot([x(1) x(end)],[opt.cutoff opt.cutoff]);
            legend('label', 'output', 'cut-off');
            for j = 2: numel(bdr)-1
                plot([bdr(j) bdr(j)], [0 1], 'k');
            end
            %legend('boundary')
            if (opt.pauseTime == -1)
                pause();
            else
                pause(opt.pauseTime);
            end
            hold off;
        end
    end
end