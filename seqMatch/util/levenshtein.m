function ed = levenshtein(str1,str2)
    n = size(str1, 2);
    m = size(str2, 2);
    d = zeros(m+1, n+1);
    d(1,:) = 0:n;
    d(:,1) = 0:m;
    for i = 2:m+1
        for j = 2:n+1
            cost = (str1(j-1) ~= str2(i-1));
            d(i,j) = min([d(i-1,j)+1, d(i,j-1)+1, d(i-1,j-1)+cost]);
        end
    end
    ed = d(m+1,n+1);
end