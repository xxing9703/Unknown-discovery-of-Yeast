% this script is to find formula for 3 groups of pks: arti,YMDB and other
% with Cnum and without Cnum, making bar plots and comparisons

% N number is restricted to 12, ppm = 3, negative mode
% first load pks for example

addpath('C:\Users\xxing\Documents\projects\workflow_untargeted\yeast\app tools');
addpath('C:\Users\xxing\Documents\projects\workflow_untargeted\yeast\paper draft');
load md_bgtree.mat

%pks=pks1_IO;

for i=1:length(pks)
    if ~isempty(pks(i).Feature) 
        pks(i).cat=1;  %artifact
    elseif ~isempty(pks(i).YMDB.formula)
        pks(i).cat=2;  % YMDB
    elseif ~isempty(pks(i).HMDB.formula)
        pks(i).cat=3;  % HMDB
    else
        pks(i).cat=4;  % unannotated
    end
end
[length(find([pks.cat]==1)),length(find([pks.cat]==2)),length(find([pks.cat]==3)),length(find([pks.cat]==4))]
stat{1}=Cnum_get_stat(pks([pks.cat]==1),md);
stat{2}=Cnum_get_stat(pks([pks.cat]==2),md);
stat{3}=Cnum_get_stat(pks([pks.cat]==3),md);
stat{4}=Cnum_get_stat(pks([pks.cat]==4),md);

% stat2=Cnum_get_stat(pks([pks.cat]==2),md);
% stat3=Cnum_get_stat(pks([pks.cat]==4|[pks.cat]==3),md);

%%
f=figure('Units','normalized','Position',[0.2,0.2,0.5,0.4]);
n=4; cl='ybcrgm';

for i=1:n
  for j=1:3
    subplot(3,n,(j-1)*n+i)  
    histogram(stat{i}(:,j),'FaceColor',cl(i));% artifact
    xlim([-1,11])
    set(gca,'fontsize', 14)
    xticklabels({'0','5','10+'})
  end
 end








