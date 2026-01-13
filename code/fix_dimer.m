function pksinfo=fix_dimer(pksinfo)
dimer=pksinfo.pairs_dimer;
ct=0;idx=[];
for i=1:length(dimer)
      
   A=pksinfo.pairs_adduct([pksinfo.pairs_adduct.childIndex]==dimer(i).parentIndex);
   if ~isempty(A)
       for j=1:length(A)
           if strcmp(A(j).name,'dbl')
               ct=ct+1;
               idx=[idx,i];
           end
       end
   end
end
dimer(idx)=[];
pksinfo.pairs_dimer=dimer;


