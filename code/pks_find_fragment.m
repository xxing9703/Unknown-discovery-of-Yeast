function frag_info=pks_find_fragment(pks,dti_CID,pvalue,ratio)
fprintf('find CID_fragment...');
ct=0;
for i=1:length(pks)
  stat_CID=cal_intens_stat(pks(i).intens,dti_CID);  
   p=stat_CID.p;
   r=stat_CID.ratio;
    frag=0;
   for j=2:length(p)
    if p(j)<pvalue && r(j)>ratio
        frag=1;        
    end
   end   
       frag_info(i).id=pks(i).id;
       frag_info(i).Index=pks(i).Index;
       frag_info(i).sig=stat_CID.avg;
       frag_info(i).p=min(p);
       
  if frag==1
       ct=ct+1;
       frag_info(i).flag=1;
  else
       frag_info(i).flag=0;
  end
end
fprintf('Done\n')