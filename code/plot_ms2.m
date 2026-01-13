function ax=plot_ms2(ax,pk,clean)
dt=[];
if ~isempty(pk.ms2info)
   if clean==1 
     if ~isempty(pk.ms2info.MS2_ms_clean) 
        dt=pk.ms2info.MS2_ms_clean;
        title(ax,'MS2 clean')
     end
   elseif clean==0
     if ~isempty(pk.ms2info.MS2_ms) 
        dt=pk.ms2info.MS2_ms;
         title(ax,'MS2 original')
     end
   end
end

if ~isempty(dt)
    stem(ax,dt(:,1),dt(:,2),'.');
    text(ax,dt(:,1),dt(:,2),num2str(dt(:,1)))
    xlabel(ax,'m/z');
end