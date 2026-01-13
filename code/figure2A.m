load('..\results\pks1_RT.mat')

mypks=pks([pks.cat]==1);
mypks1=mypks;
mypks2=mypks;
% for i=1:length(mypks)    
%     mypks1(i).Cinfo.Cshift=mypks(i).Cinfo.Cshift+1;
%     mypks2(i).Cinfo.Cshift=mypks(i).Cinfo.Cshift-1;
% end
for i=1:length(mypks)        
    mypks1(i).Cinfo.Cshift=mypks(i).Cinfo.Cshift+(round(rand)-0.5)*2;
    mypks2(i).mz=mypks(i).mz+(round(rand)-0.5)*2;
end

stat{1}=Cnum_get_stat(mypks,md);
stat{2}=Cnum_get_stat(mypks1,md);
stat{3}=Cnum_get_stat(mypks2,md);

f=figure('Units','normalized','Position',[0.2,0.2,0.5,0.4]);
n=3; cl='ybcrgm';

for i=1:n
  for j=1:3
    subplot(3,n,(j-1)*n+i)  
    histogram(stat{i}(:,j),'FaceColor',cl(i));% artifact
    xlim([-1,11])
    set(gca,'fontsize', 14)
    xticklabels({'0','5','10+'})
  end
 end
