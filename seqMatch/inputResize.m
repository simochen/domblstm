function [sX, mX] = inputResize(sX, mX)
    for i = 1: 3100
        sX{i}(:,1:20) = sX{i}(:,1:20)/20;
    end
    for i = 1: 720
        mX{i}(:,1:20) = mX{i}(:,1:20)/20;
    end
end