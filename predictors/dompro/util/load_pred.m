function pred = load_pred(type, isSave)
%USAGE: pred = load_pred(filename, isSave)
%pred -> {label, range}
    domfile = sprintf('../data/%s_dom.txt', type);
    fid = fopen(domfile);
    i = 0;
    while ~feof(fid)
        i = i+1;
        fgetl(fid);
        line = fgetl(fid);
        cnt = str2double(line(30));
        for j = 1:cnt
            line =  fgetl(fid);
            idx1 = strfind(line,':');
            idx2 = strfind(line,'-');
            pred(i).range(j,1) = str2double(line(idx1+2:idx2-2));
            pred(i).range(j,2) = str2double(line(idx2+2:length(line)));
        end
    end
    fclose(fid);

    for i = 1: numel(pred)
        outfile = sprintf('../data/%s/%d.out', type, i);
        fid = fopen(outfile);
        fgetl(fid);
        line = fgetl(fid);
        pred(i).label = zeros(1, length(line));
        for j = 1: length(line)
            if line(j) == 'T'
                pred(i).label(j) = 1;
            end
        end
        fclose(fid);
    end
    
    if isSave
        savefile = sprintf('../dataproc/%s_pred.mat', type);
        save(savefile, 'pred');
    end
end