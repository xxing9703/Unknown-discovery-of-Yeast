pk=[];
Clim=100;

% pick one species below
load("D:\yeast paper\results\pks1_RT_deepmet.mat")
pks1=pks([pks.cat]==4);
for i=1:length(pks1)
  if size(pks1(i).formulainfo,1)==1
      if pks1(i).Cinfo.Cshift<=Clim
       pk=[pk;pks1(i)];
      end
  end
end

load("D:\yeast paper\results\pks1_IO_deepmet.mat")
pks1=pks([pks.cat]==4);
for i=1:length(pks1)
  if size(pks1(i).formulainfo,1)==1
      if pks1(i).Cinfo.Cshift<=Clim
       pk=[pk;pks1(i)];
      end
  end
end

load("D:\yeast paper\results\pks1_SC_deepmet.mat")
pks1=pks([pks.cat]==4);
for i=1:length(pks1)
  if size(pks1(i).formulainfo,1)==1
      if pks1(i).Cinfo.Cshift<=Clim
       pk=[pk;pks1(i)];
      end
  end
end

%%
mypks=[];
for i=1:length(pk)
  mypks(i).Index=pk(i).Index;
  mypks(i).mz=pk(i).mz;
  mypks(i).rt=pk(i).rt;
  mypks(i).formula=pk(i).formulainfo{1};
  mypks(i).sig_RT=log10(mean([pk(i).RT_12C_01,pk(i).RT_12C_02,pk(i).RT_12C_03])+1);
  mypks(i).sig_IO=log10(mean([pk(i).IO_12C_01,pk(i).IO_12C_02,pk(i).IO_12C_03])+1);
  mypks(i).sig_SC=log10(mean([pk(i).SC_12C_01,pk(i).SC_12C_02,pk(i).SC_12C_03])+1);
end

for i=1:length(pk)
    for j=1:length(pk(i).deepmetinfo)
      mypks(i).(['SMILES',num2str(j)])=pk(i).deepmetinfo(j).smiles{1};
    end
end


