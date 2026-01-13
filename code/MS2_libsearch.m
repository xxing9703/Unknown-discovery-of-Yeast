% example 
% db=sqlite('C:\Users\xxing\Downloads\MS2ID_Bio_v09102023\db.sqlite');
% tbs={'massbank_negDB','MoNAbank_negDB','MSDial_negDB','GNPS_negDB','HMDBexperimental_negDB','RIKEN_negDB','MINES_negDB'};
% MS2_libsearch(db,tbs,formula,ms2)

%output: lib is best matched lib entry,  libms2 is MS2 from lib, num is
%totel number of matched formula

function [score,lib,libms2,num]=MS2_libsearch(db,tbs,formula,ms2)
ct=0; num=0;
score(1)=0;
for n=1:length(tbs)
  sqlquery = ['SELECT * FROM ',tbs{n}];
  rf = rowfilter("Formula");
  rf = rf.Formula == formula;
  try  
    sublib = fetch(db,sqlquery,"RowFilter",rf);  
    num=num+size(sublib,1);
    if ~isempty(sublib)
      for  i=1:size(sublib,1)
       sA=str2num(sublib{i,14}); % retrieve MS2 in lib
       sB=ms2;
       sc=dot_prod(sA,sB,0.1); 
       ct=ct+1;
       score(ct)=sc;
       spec{ct}=sA;
       lib{ct}=sublib;
      end
    end    
  catch
  end
end
[score,idx]=max(score);
if score>0
    libms2=spec{idx};
    lib=lib{idx};
else
    libms2=[];
    lib=[];
end
