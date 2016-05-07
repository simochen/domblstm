function linker = getLinker(range)
    %USAGE: linker = getLinker(range)
    %range -> rangeNum * 2 double
    %if domain linker region is empty, return linker = []
    linker = [];
    num = size(range,1);
    for i = 1:num-1
        if range(i+1,1)-range(i,2)-1 > 0
            linker = [linker; [range(i,2)+1 range(i+1,1)-1]];
        end
    end
end