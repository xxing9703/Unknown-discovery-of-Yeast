T0=table2struct(readtable('db_YMDB'));

% remove unusual elements
idx=[];
for i=1:length(T0)
  if prod(ismember(T0(i).Formula,'CHNOSP0123456789l'))
      idx=[idx,i];
  end
end
T=T0(idx);


% find mz and Cnum relationship
for i=1:length(T)  
    [mz,~,ct]=formula2mass(T(i).Formula);
    crule(i,1)=mz;
    crule(i,2)=ct(1);
end


%%  given mz, plot Cnum distribution
mz=500.28;
ind=find(crule(:,1)<mz+10 & crule(:,1)>mz-10);
figure, histogram(crule(ind,2));
%%  create heatmap
mydt=[];
for i=1:100
    i
    mz=i*10;
ind=find(crule(:,1)<mz+5 & crule(:,1)>mz-5);
   tp=crule(ind,2);
   for j=1:70
      mydt(i,j)=min(length(find(tp==j)),100);
   end
end
figure, h=heatmap(mydt');
