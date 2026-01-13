pks=pks1_IO_f1;  % current working pks (IO or Rt)
pdfout='IO_output_v2\';
% filter those without ms2info(artifacts)
for i=1:length(pks)
    pks(i).score=pks(i).Cinfo.Cscore(pks(i).Cinfo.Cshift);
   if isempty(pks(i).ms2info)
       pks(i).score=0;
   else
       if isempty(pks(i).ms2info.MS2_ms_clean)
           pks(i).score=0;
       end
   end   

end

pks1=pks([pks.score]>0);

% save pdf
for nn=1:length(pks1)    
    pk=pks1(nn);
    pipeline2
    pause(1.2)
    fn=[pdfout, 'pkid=',num2str(pk.Index,'%03d'),'.pdf'];
    exportapp(fig, fn);
    close(fig);
end

