function [AB,spec_m]=merge_specAB(A,B,tol)
mz=[A(:,1);B(:,1)];
intens=[A(:,2)/sum(A(:,2));B(:,2)/sum(B(:,2))];
flagA=[ones(size(A,1),1);zeros(size(B,1),1)];
flagB=[zeros(size(A,1),1);ones(size(B,1),1)];
combo=[mz,intens,flagA,flagB];
[~,ind]=sort(mz);
combo=combo(ind,:);

spec_m=[];
ct=1;i=1;
while i<size(combo,1)
 if abs(combo(i+1,1)-combo(i,1))<tol && combo(i+1,3)+combo(i,3)==1
     spec_m(ct,:)=[(combo(i,1)+combo(i+1,1))/2,combo(i,2)*combo(i,3)+combo(i+1,2)*combo(i+1,3),combo(i,2)*combo(i,4)+combo(i+1,2)*combo(i+1,4)];
     i=i+2;
     ct=ct+1;
 else
     spec_m(ct,:)=[combo(i,1),combo(i,2)*combo(i,3),combo(i,2)*combo(i,4)];
     ct=ct+1;
     i=i+1;
 end
end
if i==size(combo,1)  %add the last item if not merged
    spec_m(ct,:)=[combo(i,1),combo(i,2)*combo(i,3),combo(i,2)*combo(i,4)];
end

AB=[spec_m(:,1),(spec_m(:,2)+spec_m(:,3))/2];

