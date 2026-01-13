load ('..\results\pks1_RT_deepmet_ms2.mat')
mypks=pks([pks.cat]==4);

%pull out YMDB & formula info

for i=1:length(mypks)
    mypks(i).Cshift=mypks(i).Cinfo.Cshift;
    mypks(i).F_YMDB=mypks(i).YMDB.formula;
    mypks(i).F_HMDB=mypks(i).HMDB.formula;
    try
    mypks(i).F1=mypks(i).formulainfo{1,1};
    mypks(i).F2=mypks(i).formulainfo{2,1};
    catch
    end
    
end

ct=0;idx=[];idx0=[];
for i=1:length(mypks)
    if strcmp(mypks(i).F_HMDB,mypks(i).F1) || strcmp(mypks(i).F_HMDB,mypks(i).F2)
        ct=ct+1;
        idx0=[idx0,i];
    else
        idx=[idx,i];
    end
end
pp0=mypks(idx0);
pp1=mypks(idx);

