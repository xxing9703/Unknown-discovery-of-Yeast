load pks.mat

%pks2 is unknowns with C shift.; pks22 is metabolite with C shift;
pks22=pks1(strcmp({pks1.Feature},'Metabolite'));

folder='inclusion_neg_known';
pks_sub=pks22;
fn = 'neg_SC_ms2list';

tb=[];fname=[];
m=20;  % number of max peaks in each file
rt_window=3;

[A,B]=xlsread('template2.csv');  % template format
file_ct=0;
ss=length(pks_sub);
N=floor(ss/m)+1;  %separate into N files.    
[a,b]=sort([pks_sub.rt]); % sort rt, b is the index.
for files=1:N
   file_ct=file_ct+1; %file counts
   fname{file_ct}=[fn,num2str(file_ct,'%03d'),'.csv'];  %filenames
   ct=1;out=[];
   for kk=1:size(B,2)
     out{ct,kk}=B(1,kk); %top row of column names
   end
   for j=files:N:ss  % pick one from every N in sorted rt
        ct=ct+1;
        out{ct,1}=['ID=',num2str(pks_sub(j).Index)];                     
        out{ct,4}=pks_sub(j).mz;
        out{ct,5}=1;
        out{ct,6}=pks_sub(j).rt-rt_window/2;
        out{ct,7}=pks_sub(j).rt+rt_window/2;
    end
    tb{file_ct}=out;
end

for i=1:length(tb)
    c=tb{i};
    tp=cell2table(c);
    writetable(tp,fullfile(folder,fname{i}),'writevariablenames', false);    
end