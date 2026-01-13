% input a pk, M structure of the (blk,12C,12C,12C,13C,13C,13C) data
% output Cshift, score, plot, etc
function pks=pks_add_Cinfo(pks,M,settings)
for n=1:length(pks)
   patt=[]; out=[];
   pk=pks(n);
   mz=pk.mz;
   cmax=ceil(mz/14)+1;
   for i=1:cmax      
      pk.mz=mz+(i-1)*1.00335;
      [~,tp,~]=EIC(M,pk,settings);  
      patt(i,:)=tp';           
   end
   Cscore=[];
   for i=1:size(patt,1)-2
       s=0.011*i;
       pt1=[1,1,1,s,s,s]; 
       pt2=[pt1(end:-1:1),0,0,0]; 
       pt=[pt1,pt2];
       
       dt1=[patt(1,2:4),patt(2,2:4)];
       dt2=[patt(1+i-1,5:7),patt(1+i,5:7),patt(1+i+1,5:7)];
       dt=[dt1,dt2];
    
       %tp=corrcoef(pt,dt);score(i)=tp(1,2);
       Cscore(i)=pt*dt'/(sqrt(sum(pt.^2))*sqrt(sum(dt.^2)));
       out{i,1}=pt;
       out{i,2}=dt/max(dt);
    end
    [~,Cshift]=max(Cscore);
    pk.Cinfo.Cshift=Cshift;
    pk.Cinfo.Cscore=Cscore;
    pk.Cinfo.out=out;
    pk.Cinfo.patt=patt;
    pks(n).Cinfo=pk.Cinfo;
end




% if disp==1 
%    f=figure;
%    tiledlayout(2, 2);
%    nexttile
%    txt=['peak id = ',num2str(pk.Index),'\n'];
%    txt=[txt,'mz = ',num2str(pk.mz),'\n'];
%    txt=[txt,'rt = ',num2str(pk.rt),'\n'];
%    txt=[txt,'Formula: ',pk.Formula,'\n'];
%    txt=[txt,'Cshift = ',num2str(Cshift),'\n'];
%    txt=[txt,'CScore = ',num2str(max(score)),'\n'];
%    text(0,0.5, sprintf(txt));
%    Ax = gca;
%    Ax.Visible = 0;
%    nexttile %  figure 1 --  labeling pattern
%    ax{1}=bar(patt);
%    bh(1).FaceColor=[0.9,0.9,0.9];
%    bh(2).FaceColor=[0,0,1];
%    bh(3).FaceColor=[0,0,1];
%    bh(4).FaceColor=[0,0,1];
%    bh(5).FaceColor=[1,0,0];
%    bh(6).FaceColor=[1,0,0];
%    bh(7).FaceColor=[1,0,0];
%    xticks(1:cmax)
%    xticklabels(num2str([0:cmax-1]'));
%    xlabel('Carbon shift')
%    ylabel('abs intensities')
%    set(gca,'fontsize', 8)    
% 
%   nexttile %   figure 2  -- pattern, sim vs. exp
%    ax{2}=bar([out{Cshift,1};-out{Cshift,2}]');
%    xlim([0,13])
%    xticks(1:12)
%    xticklabels(num2str([1:13]'));
%    set(gca,'fontsize', 8)
% 
%  nexttile % figure 3 -- Cshift - score
%    ax{3}=stem(score,'.','LineWidth',2);
%    ylim([0.6,1])
%    xlabel('Carbon Number')
%    ylabel('Score')
%    set(gca,'fontsize', 8)
% end
