function postproc(s, win, cv, filename)
%USAGE: postproc(10, 5, 5, '.mat')
load('../r10/allseg.mat')
load('../mgroup5.mat')
load(filename)

p = 1;
for i = 1:144
    cv_label{i} = multi_y{mg{cv}(i)};
    cv_y{i} = y(:,p: p+length(cv_label{i})-1);
    p = p+length(cv_label{i});
    win_y{i} = mean(cv_y{i}(s+1-win:s+1+win,:));
    for j = 1: 2*win+1
        ex_y{i}(j,:) = [zeros(1, j-1) cv_y{i}(s-win+j,:) zeros(1, 2*win+1-j)];
    end
    mean_y{i} = mean(ex_y{i});
    mean_y{i} = mean_y{i}(win+1:end-win);
    %x = 1:length(cv_label{i});
    %plot(x, win_y{i}, x, cv_label{i}, x, mean_y{i});
    %pause(0.3);
end
save pred.mat win_y mean_y
end
