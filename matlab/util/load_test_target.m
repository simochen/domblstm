function obj = load_test_target(deffile)
%USAGE: obj = load_test_target(deffile)
%obj -> {seqname, len, range, rangei}
%obj.rangei -> ignore n-,c-terminal
%example: multi = load_seq('def_multi.txt')
    addpath ~/Code_Workspace/GDesign/casp11
    fid = fopen(deffile);
    i = 1;
    while ~feof(fid)
        line = fgetl(fid);
        obj(i).seqname = line(1:5);
        obj(i).len = str2double(line(7:end));
        fgetl(fid);
        line = fgetl(fid);
        idx1 = strfind(line,'(');
        idx2 = strfind(line,'-');
        idx3 = strfind(line,')');
        for j = 1:numel(idx1)
            obj(i).range(j,1) = str2double(line(idx1(j)+1:idx2(j)-1));
            obj(i).range(j,2) = str2double(line(idx2(j)+1:idx3(j)-1));
        end
        % rangei: ignore terminal
        obj(i).rangei = obj(i).range;
        obj(i).rangei(1, 1) = 1;
        obj(i).rangei(end, 2) = obj(i).len;
        
        i = i+1;
    end
    fclose(fid);
    
end