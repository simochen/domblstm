function yi = assign_label(len, range, r)
%USAGE: yi = assign_label(len, range, r)
%range: domain range
%len: sequence length
%r: expand length
%yi -> ignore n-,c-teminal
    yi = zeros(1, len);
    for i = 1: size(range, 1)-1
        left = range(i,2)-r+1;
        right = range(i+1,1)+r-1;
        yi(left:right) = 1;
    end
end