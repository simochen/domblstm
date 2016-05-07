function [pos, maxNum] = priMax(a,b,c)
%USAGE: [pos, maxNum] = priMax(a,b,c)
%priority in find maxmum: a > b > c
%maxNum = a -> pos = [-1, -1] -> left-up
%maxNum = b -> pos = [0, -1]  -> left
%maxNum = c -> pos = [-1, 0]  -> up
    pos = [-1,-1];      %left-up
    maxNum = a;
    if(b > maxNum)
        maxNum = b;
        pos = [0,-1];   %left
    end
    if(c > maxNum)
        maxNum = c;
        pos = [-1,0];   %up
    end
end