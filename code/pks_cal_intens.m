function pks=pks_cal_intens(pks,M,settings,grp1,grp2)
fprintf('calculate intensities:started....\n');
for i=1:length(pks) 
       [~,intensity,~]=EIC(M,pks(i),settings);     
         pks(i).intens=intensity;
         [~,ind]=max(pks(i).intens);
         pks(i).intens_highest=ind;
    if settings.verbose==1 && mod(i,100)==0
          fprintf(['calculate intensities:',num2str(i),'\n']);
    end
end
fprintf(['calculate intensities:',num2str(i),'\n','Done\n']);

if nargin>3  % assign pks.sig (mean signal for the samples)
 tp=[pks.intens];
 tp=tp(grp1,:);
 out=num2cell(log10(mean(tp)+1));
 [pks.sig]=out{:};
end

if nargin>4  % assign pks.sig (mean signal for the samples)
 tp=[pks.intens];
 tp=tp(grp2,:);
 out=num2cell(log10(mean(tp)+1));
 [pks.sig2]=out{:};
end



