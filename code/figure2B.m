T=readtable("db_YMDB.csv");
[F,ind]=unique(T{:,3});
F=F(2:end);

% remove unusual elements, high mz and inorganic
idx=[];
for i=1:length(F)
  [mz,~,tp]=formula2mass(F{i});
  if prod(ismember(F{i},'CHNOSP0123456789l')) && mz<=1000 && tp(1)>=1
      idx=[idx,i];
  end
end
F=F(idx);

for i=1:length(F)
    [mz,~,tp]=formula2mass(F{i});
    mypks{1}(i).mz = mz-1.00728;
    mypks{1}(i).Cinfo.Cshift=tp(1);
end


mypks{2}=mypks{1};
mypks{3}=mypks{1};

for i=1:length(mypks{1})        
    mypks{2}(i).Cinfo.Cshift=mypks{2}(i).Cinfo.Cshift+(round(rand)-0.5)*2;
    mypks{3}(i).mz=mypks{3}(i).mz+(round(rand)-0.5)*2;
end

for i=1:3
  stat{i}=Cnum_get_stat(mypks{i},md);
end

% ---------------------------------------------------------
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
%------------------------------------------------------------
f=figure('Units','normalized','Position',[0.2,0.2,0.5,0.4]);
aa=[];
for i=1:3
subplot(3,1,i) 
aa{i}(:,1) = [sum(stat{i}(:,1)==0),sum(stat{i}(:,1)==1),sum(stat{i}(:,1)>1)];
aa{i}(:,2) = [sum(stat{i}(:,2)==0),sum(stat{i}(:,2)==1),sum(stat{i}(:,2)>1)];
aa{i}(:,3) = [sum(stat{i}(:,3)==0),sum(stat{i}(:,3)==1),sum(stat{i}(:,3)>1)];
h=bar(aa{i}','stacked');
box off;
set(gca, 'XTickLabel', []); 
end

legend({'no formula','unique formula','2+ fomula'})

%--------------------------------------------------------
f=figure('Units','normalized','Position',[0.2,0.2,0.5,0.4]);
h=bar([aa{1}';zeros(3,3);aa{2}';zeros(3,3);aa{3}'],'stacked');
box off;
set(gca, 'XTickLabel', []); 
set(gca, 'YTickLabel', []); 
set(gca, 'XTick', []); 
set(gca, 'YTick',[])