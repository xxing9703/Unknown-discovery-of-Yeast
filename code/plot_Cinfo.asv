% flag=1: patten plot
% flag=2: score plot
% flag=3: Cshift plot
function ax=plot_Cinfo(ax,Cinfo,flag)
  if flag==1 
   bh=bar(ax,Cinfo.patt);
   bh(1).FaceColor=[0.9,0.9,0.9];
   bh(2).FaceColor=[0.1660,0.3430,0.9450];
   bh(3).FaceColor=[0.1660,0.3430,0.9450];
   bh(4).FaceColor=[0.1660,0.3430,0.9450];
   bh(5).FaceColor=[0.8660,0.3290,0];
   bh(6).FaceColor=[0.8660,0.3290,0];
   bh(7).FaceColor=[0.8660,0.3290,0];
   xticks(ax,1:length(Cinfo.Cscore))
   xticklabels(ax,num2str([0:length(Cinfo.Cscore)-1]'));
   xlabel(ax,'Carbon shift')
   ylabel(ax,'abs intensities')   
   set(ax,'fontsize', 8)   
  elseif flag==2
   %bar(ax,[Cinfo.out{Cinfo.Cshift,1};-Cinfo.out{Cinfo.Cshift,2}]');
   b1=bar(ax,Cinfo.out{Cinfo.Cshift,1},0.5);   
   b1.FaceColor = 'flat';
   for i=7:12
     b1.CData(i,:)=[0.98,0.95,0.90];
   end
   for i=1:6
     b1.CData(i,:)=[0.90,0.93,0.98];
   end
   hold(ax,'on')
   b2=bar(ax,-Cinfo.out{Cinfo.Cshift,2},0.5);
   b2.FaceColor = 'flat';
   for i=7:12
     b2.CData(i,:)=[0.8660,0.3290,0];
   end
   for i=1:6
     b2.CData(i,:)=[0.1660,0.3430,0.9450];
   end
   
   xlim(ax,[0,12.5])
   xticks(ax,1:12)
   xticklabels(ax,num2str([1:13]'));
   
   set(ax,'fontsize', 10)
  elseif flag==3
   stem(ax,Cinfo.Cscore,'.','LineWidth',2);
   ylim(ax,[0.6,1])
   xlabel(ax,'Carbon Number')
   ylabel(ax,'Score')
   set(ax,'fontsize', 10)
  end