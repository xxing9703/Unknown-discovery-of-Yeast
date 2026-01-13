% load MS2lib db
db=sqlite('C:\Users\xxing\Downloads\MS2ID_Bio_v09102023\db.sqlite');
% load pks ----------------
%% YMDB MS2 libsearch
match=[];
mypks=pks([pks.cat]==2);score=[];ct=0;
for i=1:length(mypks)
   pk=mypks(i);
   try
   myms2=pk.ms2info.MS2_ms_clean;
   formula=pk.YMDB.formula;
   [score(i),lib,libms2]=MS2_libsearch(db,tbs,formula,myms2);
   if score(i)>0.8
       ct=ct+1;
       match(ct).libms2=libms2;
       match(ct).ms2=myms2;
       match(ct).pk=pk;
       match(ct).score=score(i);
       match(ct).name=lib{1,2};
   end
   catch
     score(i)=0;  
   end
end
figure, histogram(score,50);
size(find(score>0.8),2) % match found
%% HMDB MS2 libsearch
match=[];
mypks=pks([pks.cat]==3);score=[];ct=0;
for i=1:length(mypks)
   pk=mypks(i);
   try
   myms2=pk.ms2info.MS2_ms_clean;
   formula=pk.HMDB.formula;
   [score(i),lib,libms2]=MS2_libsearch(db,tbs,formula,myms2);
   if score(i)>0.8
       ct=ct+1;
       match(ct).libms2=libms2;
       match(ct).ms2=myms2;
       match(ct).pk=pk;
       match(ct).score=score(i);
       match(ct).name=lib{1,2};
   end
   catch
     score(i)=0;  
   end
end
figure, histogram(score,50);
size(find(score>0.8),2) % match found

%% unknown MS2 libsearch

mypks=pks([pks.cat]==4);score=[];
for i=1:length(mypks)   
   pk=mypks(i);
   try
   myms2=pk.ms2info.MS2_ms_clean;
   formula=pk.formulainfo{1,1};
   [score(i),lib]=MS2_libsearch(db,tbs,formula,myms2);
   catch
     score(i)=0;  
   end
end
figure, histogram(score,50);
size(find(score>0.8),2)

%%

% YMDB/HMDB MS2lib match for RT  50/19  
% YMDB/HMDB MS2lib match for IO  55/17
% N/A for S.c

%%  ---------- plot group
figure
for n=1:16
subplot(4,4,n)
stem(match(n).libms2(:,1),match(n).libms2(:,2)/max(match(n).libms2(:,2)),'.')
hold on
stem(match(n).ms2(:,1),-match(n).ms2(:,2)/max(match(n).ms2(:,2)),'.')
ylabel(['mz=',num2str(match(n).pk.mz)]);
title(match(n).name);
%legend(['score=',num2str(match(n).score)]);
end

%% -------------- plot single
n=5;
 f=figure('Units','normalized','Position',[0.2,0.2,0.2,0.2]);
stem(match(n).libms2(:,1),match(n).libms2(:,2)/max(match(n).libms2(:,2)),'.')
hold on
stem(match(n).ms2(:,1),-match(n).ms2(:,2)/max(match(n).ms2(:,2)),'.')
%ylabel(['mz=',num2str(match(n).pk.mz)]);
title(match(n).name);
xlabel('m/z');
yticks('');
yticklabels('');
