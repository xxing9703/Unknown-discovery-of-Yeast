%required input: pks struct with .mz/.rt/.sig
%required input: adduct struct .name/.diff
%required input: loose criteria ppm, rtm
%output: adduct pair struct: adductID/parentID/feature/name/ppm/rtm
function adduct_pair=pks_find_adduct(pks,adduct,ppm,rtm)
%initial setup
%adduct=readtable('adduct_list_neg.xlsx'); %+++++++ load adduct table
%adduct=table2struct(adduct);
%load pks04 %+++++++ load pks
%ppm=10;rtm=0.3; %++++++ settings
fprintf('calculate:adduct pair......')
adduct_pair=[];
[~,B]=sort([pks.mz]); %sort pks.mz
pks_sorted=pks(B);
[~,B]=sort([adduct.diff]); %sort adduct.mz
adduct_sorted=adduct(B);

sz=length(pks_sorted);
ct=0;
for k=1:length(adduct_sorted)
    dif=abs(adduct_sorted(k).diff);
    a=[pks_sorted.mz];  %mz sorted array
    i=2;j=1; %start point 

tp=0;
while i<=sz  % i -- higher mass, j -- lower mass
    if a(i)-a(j)<=dif+a(j)*ppm
       if a(i)-a(j)>=dif-a(j)*ppm % within range, matches mass diff
           if abs(pks_sorted(i).rt-pks_sorted(j).rt)<=rtm  % and rt match
            ct=ct+1;
            if adduct_sorted(k).diff>0  %negative sign
                ii=i;jj=j;
            else
                ii=j;jj=i;                               
            end
            adduct_pair(ct).childID=pks_sorted(ii).id;
            adduct_pair(ct).childIndex=pks_sorted(ii).Index;
            adduct_pair(ct).parentID=pks_sorted(jj).id;
            adduct_pair(ct).parentIndex=pks_sorted(jj).Index;
            
            adduct_pair(ct).feature=adduct_sorted(k).feature;
            adduct_pair(ct).name=adduct_sorted(k).name; 
            adduct_pair(ct).ppm=round((pks_sorted(i).mz-pks_sorted(j).mz-dif)/pks_sorted(ii).mz*1e6*10)/10; 
            adduct_pair(ct).rtm=round((pks_sorted(i).rt-pks_sorted(j).rt)*1000)/1000;
            adduct_pair(ct).ratio=(pks_sorted(i).sig-pks_sorted(j).sig);
           end
           j=j+1;tp=tp+1; %in range, walk down one step,  tp++                    
       else
           i=i+1;j=j-tp;tp=0; %not in range, walk right one step, walk up tp steps if any, reset tp
       end                       
   else
       j=j+1;     %walk down one step  
   end    
end

end

fprintf('Done\n')
