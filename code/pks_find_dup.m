%expand the list without having dup
function pks=pks_find_dup(pks,ppm,rtm)
fprintf('find duplicate...')
[~,B]=sort([pks.mz]); %sort pks.mz
pks_sorted=pks(B);
%pks_sorted=flip(pks_sorted);
sz=length(pks_sorted);
ct=0;

a=[pks_sorted.mz];  %mz sorted array
flag=zeros(sz,1);
for i=2:sz
   j=i-1;
    while j>0 && abs(a(i)-a(j))<a(i)*ppm
        if flag(j)==0 && abs(pks_sorted(i).rt-pks_sorted(j).rt)<rtm
          flag(i)=1;
          break
        end
          j=j-1;
    end
end
pks=pks_sorted(flag==0);
[~,B]=sort([pks.id]);
pks=pks(B);
for i=1:length(pks)
    pks(i).Index=i;
end
fprintf('Done\n')



