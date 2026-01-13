%default setting ppm=5e-6, rtm=0.1, mode=1 or -1 , mer=2 (dimer)
function dimer_pair=pks_find_dimer(pks,ppm,rtm,mode,mer)
%mer=2;
fprintf('calculate:dimer pair......')
dimer_pair=[];
[~,B]=sort([pks.rt]); %sort pks.mz
pks_sorted=pks(B);
sz=length(pks_sorted);
b=[pks_sorted.rt];
ct=0;
%ppm=800*1e-6;
for i=1:sz  %i: parent, %j: potential 
   j=i-1;
   while j>0 && abs(b(i)-b(j))<rtm
       ppm_error=(pks_sorted(i).mz*mer-1.0078*(mer-1)*mode-pks_sorted(j).mz)/pks_sorted(j).mz;
         if abs(ppm_error)<=ppm  % mass match              
            ct=ct+1;
            dimer_pair(ct).childID=pks_sorted(j).id;
            dimer_pair(ct).childIndex=pks_sorted(j).Index;
            dimer_pair(ct).parentID=pks_sorted(i).id; 
            dimer_pair(ct).parentIndex=pks_sorted(i).Index;
            dimer_pair(ct).feature='Dimer';
            dimer_pair(ct).name='dimer';
            dimer_pair(ct).ppm=round(ppm_error*1e6*10)/10; 
            dimer_pair(ct).rtm=round((pks_sorted(i).rt-pks_sorted(j).rt)*1000)/1000;
            dimer_pair(ct).ratio=(pks_sorted(i).sig-pks_sorted(j).sig);
          end
      j=j-1;     %walk down one step  
   end 
     j=i+1;
   while j>0 && j<sz && abs(b(i)-b(j))<rtm
       ppm_error=(pks_sorted(i).mz*mer-1.0078*(mer-1)*mode-pks_sorted(j).mz)/pks_sorted(j).mz;
         if abs(ppm_error)<=ppm  % mass match              
            ct=ct+1;
            dimer_pair(ct).childID=pks_sorted(j).id;
            dimer_pair(ct).childIndex=pks_sorted(j).Index;
            dimer_pair(ct).parentID=pks_sorted(i).id; 
            dimer_pair(ct).parentIndex=pks_sorted(i).Index;
            dimer_pair(ct).feature='Dimer';
            dimer_pair(ct).name='dimer';
            dimer_pair(ct).ppm=round(ppm_error*1e6*10)/10; 
            dimer_pair(ct).rtm=round((pks_sorted(i).rt-pks_sorted(j).rt)*1000)/1000;
            dimer_pair(ct).ratio=(pks_sorted(i).sig-pks_sorted(j).sig);
          end
      j=j+1;     %walk down one step  
   end 
end
fprintf('Done\n')




