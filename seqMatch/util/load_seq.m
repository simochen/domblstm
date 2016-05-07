function [obj, test] = load_seq(seqfile, domfile, type, isSave)
%USAGE: obj = load_seq(seqfile, domfile, type, isSave)
%obj -> {seq_name, dom_name, seq, dom, len, range, rangei}
%obj.rangei -> ignore n-,c-terminal
%example: multi = load_seq('multi_seq.txt', 'multi_dom.txt', 'multi', 1)
    addpath ../data/preproc
    fid = fopen(seqfile);
    i = 1;
    while ~feof(fid)
        obj(i).seq_name = fgetl(fid);
        obj(i).seq_name = obj(i).seq_name(2:6);
        obj(i).seq =  fgetl(fid);
        obj(i).len = length(obj(i).seq);
        i = i+1;
    end
    fclose(fid);

    fid = fopen(domfile);
    i = 1;
    j = 1;
    test.overlap = [];
    test.coverage = [];
    test.dom_poi = [];
    while ~feof(fid)
        name_line = fgetl(fid);
        if ~strcmp(name_line(2:6), obj(i).seq_name)
            i = i+1;
            j = 1;
        end
        test.dom_poi = [test.dom_poi, i];
        obj(i).dom_name{j} = name_line(2:8);
        obj(i).dom{j} =  fgetl(fid);
        dlen = length(obj(i).dom{j});
        errlen = 3;
        if strcmp(type, 'multi') 
            num = 3;
            cutlen = 90;
            cutrg = floor(dlen/num);
        elseif strcmp(type, 'single')
            cutlen = 60;
            cutrg = 20;
        end
        if dlen < cutlen
            [st, ed, olp, cov] = LCS(obj(i).seq, obj(i).dom{j}, errlen);
            test.overlap = [test.overlap, olp];
            test.coverage = [test.coverage, cov];
            if st <= 3
                st = 1;
            end
            if obj(i).len - ed <= 2
                ed = obj(i).len;
            end
            obj(i).range(j,:) = [st ed];
        else
            [st, ~, olp1, cov1] = LCS(obj(i).seq, obj(i).dom{j}(1:cutrg), errlen);
            [~, ed, olp2, cov2] = LCS(obj(i).seq, obj(i).dom{j}(dlen-cutrg:dlen), errlen);
            if abs(olp1-1) > abs(olp2-1)
                olp = olp1;
            else
                olp = olp2;
            end
            if abs(cov1-1) > abs(cov2-1)
                cov = cov1;
            else
                cov = cov2;
            end
            test.overlap = [test.overlap, olp];
            test.coverage = [test.coverage, cov];
            if st <= 3
                st = 1;
            end
            if obj(i).len - ed <= 2
                ed = obj(i).len;
            end
            obj(i).range(j,:) = [st ed];
        end
        j = j+1;
    end
    fclose(fid);
    
    for i = 1:numel(obj)
        len = obj(i).len;
        % sort domain range
        obj(i).range = sort(obj(i).range, 1);
        % rangei: ignore terminal
        obj(i).rangei = obj(i).range;
        obj(i).rangei(1, 1) = 1;
        obj(i).rangei(end, 2) = len;
    end
    
    if isSave
        savefile = sprintf('../data/process/%s_seqinfo.mat', type);
        save(savefile, 'obj');
    end
end