function pks=cal_intens_EIC(M,pks,settings)
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