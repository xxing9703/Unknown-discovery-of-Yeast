% defalt settings: ppm=800e-6, rtm=0.1, signal_diff=2
function arti_pair=pks_find_ringing(pks,ppm,rtm,signal_diff)
fprintf('calculate artifact pairs......')
arti_pair=[];
[~,B]=sort([pks.mz]); %sort pks.mz
pks_sorted=pks(B);
sz=length(pks_sorted);
a=[pks_sorted.mz];
ct=0;
%ppm=800*1e-6;
for i=1:sz  %i: parent, %j: potential artifact
   j=i-1;
   while j>0 && abs(a(i)-a(j))<a(i)*ppm
         if abs(pks_sorted(i).rt-pks_sorted(j).rt)<=rtm...  % rt match
              && (pks_sorted(i).sig-pks_sorted(j).sig)>signal_diff   % signal ratio match
            ct=ct+1;
            arti_pair(ct).childID=pks_sorted(j).id;
            arti_pair(ct).childIndex=pks_sorted(j).Index;
            arti_pair(ct).parentID=pks_sorted(i).id;
            arti_pair(ct).parentIndex=pks_sorted(i).Index;
            arti_pair(ct).feature='Artifact';
            arti_pair(ct).name='artifact';
            arti_pair(ct).ppm=round((pks_sorted(i).mz-pks_sorted(j).mz)/pks_sorted(i).mz*1e6*10)/10; 
            arti_pair(ct).rtm=round((pks_sorted(i).rt-pks_sorted(j).rt)*1000)/1000;
            arti_pair(ct).ratio=(pks_sorted(j).sig-pks_sorted(i).sig);
          end
      j=j-1;     %walk down one step  
   end 
      j=i+1;
   while j>0 && j<sz && abs(a(i)-a(j))<a(i)*ppm
         if abs(pks_sorted(i).rt-pks_sorted(j).rt)<=rtm...  % rt match
              && (pks_sorted(i).sig-pks_sorted(j).sig)>signal_diff   % signal ratio match
            ct=ct+1;
            arti_pair(ct).childID=pks_sorted(j).id;
            arti_pair(ct).childIndex=pks_sorted(j).Index;
            arti_pair(ct).parentID=pks_sorted(i).id;  
            arti_pair(ct).parentIndex=pks_sorted(i).Index;
            arti_pair(ct).feature='Artifact';
            arti_pair(ct).name='artifact';
            arti_pair(ct).ppm=round((pks_sorted(i).mz-pks_sorted(j).mz)/pks_sorted(i).mz*1e6*10)/10; 
            arti_pair(ct).rtm=round((pks_sorted(i).rt-pks_sorted(j).rt)*1000)/1000;
            arti_pair(ct).ratio=(pks_sorted(j).sig-pks_sorted(i).sig);
          end
      j=j+1;     %walk down one step  
   end
end
p=length(unique([arti_pair.parentID]));
fprintf('Done\n')
%fprintf([' *** ',num2str(ct),' artifacts found, ','belong to ',num2str(p),' parent pks', '\n']);

