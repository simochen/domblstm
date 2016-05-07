function ovlap = linker_overlap(linker, range)
    %USAGE: ovlap = linker_overlap(linker, range)
    %range -> n*2 double, n > 0
    %linker -> m*2 double, m can be 0
    %if m = 0, return zeros(1, n)
    %return 1*n double
    num_linker = size(linker, 1);
    num_rg = size(range, 1);
    ovlap = zeros(1, num_rg);
    if num_linker > 0
        olp = zeros(num_linker, num_rg);
        for i = 1:num_linker
            for j = 1:num_rg
                [olp(i,j),~] = overlap(linker(i,:),range(j,:));
            end
        end
        ovlap = sum(olp, 1);
    end
end