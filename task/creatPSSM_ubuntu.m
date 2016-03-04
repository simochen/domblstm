%
MPI_Init;
comm=MPI_COMM_WORLD;
comm_size=MPI_Comm_size(comm);
my_rank=MPI_Comm_rank(comm);
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
swfile='/home/zhangyize/CreatPSSM1/';
species={'euk','gpos','gneg'};
kind={'_s','_t','_n'};
if my_rank==0
	comm_size=9;
end
for s=1:3
    for k=1:3
        if (mod((3*(s-1)+k),comm_size)~=my_rank)
            continue;
        end
        intitle01=[swfile,'fasta1/'];
        intitle0=[intitle01,species{s}];
        intitle1=[intitle0,kind{k}];
        intitle =[intitle1,'.txt'];
        fp_read=fopen(intitle,'r');
        tempfile0=[swfile,num2str(s)];
        tempfile1=[tempfile0,num2str(k)];
        tempfile=[tempfile1,'.txt'];
        %tempfile='/home/zhangyize/CreatPSSM/temp.txt';
        pssmfile01=[swfile,'temp/'];
        pssmfile0=[pssmfile01,num2str(s)];
        pssmfile1=[pssmfile0,num2str(k)];
        pssmfile=[pssmfile1,'.txt'];
        %pssmfile='/home/zhangyize/CreatPSSM/temp/pssm';
        
        psfile01=[swfile,'temp/'];
        psfile0=[psfile01,num2str(s)];
        psfile1=[psfile0,num2str(k)];
        psfile=[psfile1,'.out'];
        
        outitle0=[swfile,'temp/'];
        outitle1=[outitle0,species{s}];
        outitle2=[outitle1,kind{k}];
        outitle3 =[outitle2,'.txt'];
        fp_write_pssm=fopen(outitle3,'w');
        
        ID='';
        SEQ='';
        line_info=fgetl(fp_read);
        num=0;

        while ~feof(fp_read)
           num=num+1;
           disp(num);
           if strcmp(line_info(1),'>')==1;
              fp_write=fopen(tempfile,'w');
              ID=line_info(6:end);   
              fprintf(fp_write,'> gi|%d|%s\n',num,line_info(6:end));
              line_info=fgetl(fp_read);
              while strcmp(line_info(1),'>')==0
                 % SEQ=line_info; 
                  fprintf(fp_write,'%s\n',line_info(1:end));
                  if feof(fp_read)  
                      break;
                  end
                  line_info=fgetl(fp_read);
                  if strcmp(line_info,'')==1
                       line_info=fgetl(fp_read);
                      if feof(fp_read)  
                            break;
                      end
                  end
               end    
           end 
           fclose(fp_write);
           disp('I am blasting');
           comdline=sprintf('"/home/zhangyize/blast/bin/blastpgp" -e 0.001 -j 3 -h 0.001 -i "%s" -d "/home/mpiuser/ur90/uniref90" -Q "%s" -o "%s"',tempfile,pssmfile,psfile);
           status=system(comdline);

           if status==0
               fp_read_pssm=fopen(pssmfile,'r');
               disp('I am writing the ID!');
               fprintf(fp_write_pssm,'> gi|%d|%s\n',num,ID(1:end));
               line_info_pssm=fgetl(fp_read_pssm);
               while ~feof(fp_read_pssm)
                    disp('I am writing the PSSM!');
                    line_info_pssm=fgetl(fp_read_pssm);
                    fprintf(fp_write_pssm,'%s\n',line_info_pssm(1:end));  
               end 
               fclose(fp_read_pssm);
          else
                disp('It is wrong!');
           end 
        end
        disp('It is done!');
        fclose(fp_read);
        fclose(fp_write_pssm);  
    end
end
MPI_Finalize;
