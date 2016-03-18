function [res, maxNum] = priMax(a,b,c)
%找最大值时a的优先级最高，c的优先级最低
    res = [-1,-1];      %左上
    maxNum = a;
    if(b > maxNum)
        maxNum = b;
        res = [0,-1];   %左边
    end
    if(c > maxNum)
        maxNum = c;
        res = [-1,0];   %上边
    end
end