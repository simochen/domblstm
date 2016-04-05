clear all
load pred.mat
load multi.mat
[trNum, precision, recall, ndo] = evaluate(ms_cnt, ms_poi, md_range, seq_cnt, seq_poi, range);

sub = find(seq_cnt <= 3);
s_cnt = ms_cnt(sub);
cnt = seq_cnt(sub);
range_pred = [];
range_def = [];
for i = 1:length(sub)
    s_poi(i) = sum(s_cnt(1:i-1))+1;
    poi(i) = sum(cnt(1:i-1))+1;
    range_pred = [range_pred; md_range(ms_poi(sub(i)): ms_poi(sub(i))+s_cnt(i)-1,:)];
    range_def = [range_def; range_mdf(seq_poi(sub(i)): seq_poi(sub(i))+cnt(i)-1, :)];
end
%[trNum, precision, recall, ndo] = evaluate(s_cnt, s_poi, range_pred, cnt, poi, range_def);

%load single.mat
%[trNum, precision, recall, ndo] = evaluate(ss_cnt, ss_poi, sd_range, ones(1,3100), 1:3100, range);
