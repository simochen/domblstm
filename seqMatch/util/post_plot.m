function post_plot(pred, sub_vec, opt)
%USAGE: post_plot(pred, sub_vec, opt)
%pred -> {y, range}
%sub_vec -> {len, yi}
%opt -> {cutoff, pauseTime}
    for i = 1: numel(pred)
        if sub_vec(i).len <= 200
            cutoff = opt.cutoff(1);
        elseif sub_vec(i).len <= 500
            cutoff = opt.cutoff(2);
        else
            cutoff = opt.cutoff(3);
        end
        x = 1: sub_vec(i).len;
        plot(x, sub_vec(i).yi, x, pred(i).y);
        str = sprintf('Prediction of sequence: %d', i);
        title(str);
        hold on;
        plot([x(1) x(end)],[cutoff cutoff]);
        legend('label', 'output', 'cut-off');
        for j = 1: size(pred(i).range,1)-1
            plot([pred(i).range(j,2) pred(i).range(j,2)], [0 1], 'k');
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