function pks=pks_addsig(pks,M,settings)
%load M_3yeast (if not a function)
%load pks_final1.mat (if not a fuction)
%load settings_neg (if not a function)
%settings.ppm=3e-6;

for i=1:length(pks)
%    eics=[];
    for j=1:length(M)
       [eics(j,1),sig]=EIC(M(j),pks(i),settings);
      pks(i).(M(j).filename(1:end-6))=sig;  % filename removes .mzXML -6 char       
    end
    pks(i).eics=eics;
end
