function pks=pks_add_AIF(pks,M,settings)
for n=1:length(pks)
[~,sig]=EIC(M,pks(n),settings);
pks(n).AIF.sig=sig;
end

