function [start, ed, overlap, cov] = LCS(str1, str2, errlen)
    n = size(str1, 2);
    m = size(str2, 2);
    d = zeros(m+1, n+1);
    st = zeros(m+1, n+1);
    e = zeros(m+1, n+1);
    cnt = zeros(m+1, n+1);
    for i = 2:m+1
        for j = 2:n+1
            cost = (str1(j-1) == str2(i-1));
            [last,d(i,j)] = priMax(d(i-1,j-1)+cost, d(i,j-1), d(i-1,j));
            if(str1(j-1) == str2(i-1))
                if(st(last(1)+i,last(2)+j) == 0)
                    st(i,j) = j-1;
                else
                    st(i,j) = st(last(1)+i,last(2)+j);
                end
                e(i,j) = j-1;
                cnt(i,j) = 0;
            else
                st(i,j) = st(last(1)+i,last(2)+j);
                e(i,j) = e(last(1)+i,last(2)+j);
                cnt(i,j) = cnt(last(1)+i,last(2)+j)+1;
            end
            if(cnt(i,j) > errlen)
                d(i,j) = 0;
                st(i,j) = 0;
                e(i,j) = 0;
            end
        end
    end
    %C = (cnt <= errlen);
    %d = d.*C;
    %st = st.*C;
    %e = e.*C;
    [num, ind] = max(d(m+1,:));
    start = st(m+1, ind);
    ed = e(m+1, ind);
    overlap = num/m;
    cov = m/(ed+1-start);
end