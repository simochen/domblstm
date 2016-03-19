function [start, ed, overlap] = LCS(str1, str2, errlen)
    n = size(str1, 2);
    m = size(str2, 2);
    d = zeros(m+1, n+1);
    st = zeros(m+1, n+1);
    e = zeros(m+1, n+1);
    cnt = 0;
    for i = 2:m+1
        for j = 2:n+1
            cost = (str1(j-1) == str2(i-1));
            [last,maxNum] = priMax(d(i-1,j-1)+cost, d(i,j-1), d(i-1,j));
            if(str1(j-1) == str2(i-1))
                if(st(last(1)+i,last(2)+j) == 0)
                    st(i,j) = j-1;
                end
                e(i,j) = j-1;
                cnt = 0;
            else
                st(i,j) = st(last(1)+i,last(2)+j);
                e(i,j) = e(last(1)+i,last(2)+j);
                cnt = cnt+1;
            end
            if(cnt == errlen)
                d(i,j) = 0;
            end
        end
    end
    [num, ind] = max(d(m+1,:));
    start = st(m+1, ind);
    ed = e(m+1, ind);
    overlap = num/m;
end