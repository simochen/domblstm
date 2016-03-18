function [start, end] = LCS(str1, str2)
    n = size(str1, 2);
    m = size(str2, 2);
    d = zeros(m+1, n+1);
    src = zeros(m+1, n+1);
    for i = 2:m+1
        for j = 2:n+1
            cost = (str1(j-1) == str2(i-1));
            [last,maxNum] = priMax(d(i-1,j-1)+cost, d(i,j-1), d(i-1,j));
            if(str1(j-1) == str2(i-1) && ~src(last(1)+i,last(2)+j))
                src(i,j) = j-1;
            else
                src(i,j) = src(last(1)+i,last(2)+j);
            end
        end
    end
end