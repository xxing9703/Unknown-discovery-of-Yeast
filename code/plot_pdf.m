% complete peak information is required to make pdf plots.
function fig=plot_pdf(pk,prefix)
% generate gui display for individual peak
%id=291; pk=pks1_RT(id);
 %pk=pks2(id);
 if nargin<2
     prefix=[];
 else
     prefix=[prefix,'_'];
 end
fig=uifigure('Units','normalized','Position',[0.15,0.05,0.7,0.9]);
g=uigridlayout(fig,'RowHeight',{'1x','0.6x','1x','1x'},'ColumnWidth',{'1x'},'Padding',[0,0,0,0]);
g1=uigridlayout(g,'RowHeight',{'1x'},'ColumnWidth',{'1.8x','0.8x','0.8x','1.2x','0.8x'},'Padding',[0,0,0,0],'BackgroundColor','w');
g2=uigridlayout(g,'RowHeight',{'1x'},'ColumnWidth',{'1x','1x','1x'},'Padding',[0,0,0,0],'BackgroundColor','w');
g3=uigridlayout(g,'RowHeight',{'1x'},'ColumnWidth',{'1x','1x','1x'},'Padding',[0,0,0,0],'BackgroundColor','w');
g4=uigridlayout(g,'RowHeight',{'1x'},'ColumnWidth',{'1x','1x','1x','1x','1x'},'Padding',[0,0,0,0],'BackgroundColor','w');
% -----------------g1    
    txt=cellstr(['peak id = ',prefix, num2str(pk.Index)]);
    txt=[txt,cellstr(['mz = ',num2str(pk.mz),'     rt = ',num2str(pk.rt)])];
    txt=[txt,cellstr(['Annotation = ',pk.Feature,' ',pk.adductname])]; 
    txt=[txt,cellstr('--------')];
    txt=[txt,cellstr(['HMDB: ',pk.HMDB.formula])];
    if isempty(pk.HMDB.assign)
         txt=[txt,cellstr(['HMDB ID:',' '])]; 
         txt=[txt,cellstr(['HMDB Name:',' '])];   
    else
        aa=pk.HMDB.assign.HMDBID;
        bb=pk.HMDB.assign.Name;
        bb=strsplit(bb,';');
        bb=bb{1};
        txt=[txt,cellstr(['HMDB ID:',aa])];
        txt=[txt,cellstr(['HMDB Name:',bb])];
    end
    txt=[txt,cellstr(['  ppm = ',num2str(pk.HMDB.ppm)])];
    txt=[txt,cellstr('--------')];
    txt=[txt,cellstr(['YMDB:',pk.YMDB.formula])];
    if isempty(pk.YMDB.assign)
         txt=[txt,cellstr(['YMDB ID:',' '])];
         txt=[txt,cellstr(['YMDB Name:',' '])];
    else
        aa=pk.YMDB.assign.YMDBID;
        bb=pk.YMDB.assign.Name;
        bb=strsplit(bb,';');
        bb=bb{1};
        txt=[txt,cellstr(['YMDB ID:',aa])];
        txt=[txt,cellstr(['YMDB Name:',bb])];
    end    
    txt=[txt,cellstr(['  ppm = ',num2str(pk.YMDB.ppm)])];    
    
    
txa = uitextarea(g1,'Value',txt,'FontSize',16); % display basic information

    txt=cellstr(['is13C: ',pk.natinfo.is13C]);   
    txt=[txt,cellstr(['is18O: ',pk.natinfo.is18O])];
    txt=[txt,cellstr(['is37Cl: ',pk.natinfo.is37Cl])];   
    txt=[txt,cellstr(['isdbl: ',pk.natinfo.isdbl])];  
    txt=[txt,cellstr(['is13Cdbl: ',pk.natinfo.is13Cdbl])]; 
    txt=[txt,cellstr(['isNa: ',pk.natinfo.isNa])];  
    txt=[txt,cellstr('--------')];
    txt=[txt,cellstr(['C: ',pk.ms1info.nat_13C])];
    txt=[txt,cellstr(['S: ',pk.ms1info.nat_34S])];
    txt=[txt,cellstr(['Cl: ',pk.ms1info.nat_37Cl])];
txb = uitextarea(g1,'Value',txt,'FontSize',16); % display basic information
    txt=cellstr(['Cshift = ',num2str(pk.Cinfo.Cshift)]); 
    txt=[txt,cellstr(['Cscore: ',num2str(pk.Cinfo.Cscore(pk.Cinfo.Cshift))])];
       
%txc = uitextarea(g1,'Value',txt,'FontSize',16); % display basic information

if ~isempty(pk.formulainfo)
    %uitable(g1, 'data',pk.formulainfo);
    %txt=[];
    for i=1:size(pk.formulainfo,1)
      txt=[txt,cellstr([pk.formulainfo{i,1},'  ppm:',num2str(pk.formulainfo{i,3})])];
    end
else
    txt=[txt,cellstr('No formula')];
end
txt=[txt,cellstr('--------')];

% if ~isempty(pk.deepmetinfo)
%   txt=[txt,cellstr(['deepmet score:', num2str([pk.deepmetinfo(1).score])])]; 
% end
uitextarea(g1,'Value',txt,'FontSize',16);

ax=uiaxes(g1);
plot_eics(ax,pk);   % plot abundance stat

ax=uiaxes(g1);
plot_abundance(ax,pk);   % plot abundance stat

%---------------------------------------g2
ax=[];
for i=1:3         % plot Cshift info
 ax=uiaxes(g2);
 plot_Cinfo(ax,pk.Cinfo,i);
end

%------------------------------------g3
for i=1:2  % plot MS2
  ax=uiaxes(g3);
  plot_ms2(ax,pk,i-1);
end
txt=[];
if ~isempty(pk.formulainfo)
     for n=1:size(pk.formulainfo,1)
         txt=[txt,cellstr([pk.formulainfo{n,1},'  ppmerr=',num2str(pk.formulainfo{n,3})])];
     end
 try
     ms2=pk.ms2info.MS2_ms_clean;
     [~,ids]=sort(ms2(:,2),'descend');
     [frag,ct,explained,ms2out]=get_frag_formula(ms2,pk.formulainfo{1,1},10,-1);
     if size(ids,1)>10
         frag(ids(11:end),:)=[];
     end
     tbl=uitable(g3,'Data',frag,'ColumnName',{'fragment','annotation_F','NLoss','annotation_NL'});
 catch
 end
 %     
%     txt=string(frag);
%     tbl = uitextarea(g3,'Value',txt,'FontSize',16); 
end
%------------------------------------g4
drawnow();
if ~isempty(pk.deepmetinfo)
  for i=1:min(5,length(pk.deepmetinfo))  %plot deepmet info
    ax=uiaxes(g4);
    sml=pk.deepmetinfo(i).smiles{1};
    
    try
      plot_smiles(ax,sml)
    catch
    end
    
    ax.Title.String=sml(1:min(length(sml),20));
    ax.YLabel.String=pk.deepmetinfo(i).formula;
  end
end
% for i=1:5
%    lb=uilabel(g4,'Text',pk.deepmetinfo(i).smiles{1});
% end
% for i=1:5
%     lb=uilabel(g4,'Text',pk.deepmetinfo(i).formula);
% end

%exportapp(fig, 'myFigure.pdf');

