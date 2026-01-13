 
% load("D:\yeast paper\results\ms2info_RT_kn.mat")
% pks=pks_addms2info(pks,ms2info)
% load("D:\yeast paper\results\ms2info_RT_un.mat")
% pks=pks_addms2info(pks,ms2info)

function pks=pks_addms2info(pks,ms2info)

for i=1:length(ms2info)
   id=ms2info(i).index{1}(4:end);  % parse example {'ID=109'}
   id=str2num(id);

   pkid=find([pks.Index]==id);
   if ~isempty(pkid)
     pks(pkid).ms2info=ms2info(i);
   end
end




