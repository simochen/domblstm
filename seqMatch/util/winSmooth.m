function y = winSmooth(x, win)
%USAGE: y = winSmooth(x, win)
%winSize -> 2*win+1
    len = numel(x);
    y = zeros(1, len);
    for i = 1: len
        if i - win < 1
            left = 1;
        else
            left = i - win;
        end
        if i + win > len
            right = len;
        else
            right = i + win;
        end
        y(i) = sum(x(left:right))/(2*win+1);
    end
end