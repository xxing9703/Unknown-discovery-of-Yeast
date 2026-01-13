load pks01_neg  % as pks

load M_neg
addpath('C:\Users\xxing\Documents\MATLAB\myroutines');
addpath('C:\Users\xxing\Documents\projects\workflow_untargeted');
addpath('C:\Users\xxing\Documents\projects\workflow_untargeted\formula_pred')
load md_finetree
load settings_neg
idx=[];
for i=1:length(pks)
    if sum(pks(i).ispeak)>=2
        idx=[idx,i];
    end
end
pks0=pks(idx); % all good peaks (at least 2/3 good peaks)
pks1=pks0(([pks0.sig]-[pks0.sig2])>1 & [pks0.sig]>5);  % find all pks with signal > 1e5 and 1 fold signal change in 13C (labeled)
%  find C shift and stores in pks.Cshift
Cshift=[];
for nn=1:length(pks1)
    nn
    [patt,Cshift(nn)]=find_iso_pattern(pks1(nn),M,settings,0);
    C13ratio= mean(patt(2,1:3))/mean(patt(1,1:3));
    pks1(nn).Cshift=Cshift(nn);
    pks1(nn).Cnum_nat13=round(C13ratio*100/1.1);

    c=mass2formula_CN(pks1(nn).mz,[Cshift(nn),Cshift(nn)],[0,8],3,-1);
    pks1(nn).f2=[];
    if ~isempty(c)
        idx=[];
        for j=1:size(c,1)        
           tp=formula_classifier6r(c{j,1},md);
           if tp==1
               idx=[idx,j];
           end
        end
        if ~isempty(idx)
            pks1(nn).f2=c(idx,:);
        end
    end
    
end

% find Cnum and Nnum if a formula is assigned (with HMDB formula match)
for nn=1:length(pks1)
    if ~isempty(pks1(nn).Formula)
    [~,~,ct]=formula2mass(pks1(nn).Formula);
    pks1(nn).Cnum=ct(1);
    pks1(nn).Nnum=ct(2);
    else
    pks1(nn).Cnum=-1;
    pks1(nn).Nnum=-1;  
    end
end


pks2=pks1(cellfun(@isempty,{pks1.Feature}));
for i=1:length(pks2)
   pk=pks2(i);
  spectra=getMS(M(2:7),pk,0.1);
  for j=1:3
      ms_=spectra{j};
      idx=find(abs(ms_(:,1)-pk.mz)<2.1);
      if ~isempty(idx)
        top(j)=max(ms_(idx,2));
      else
        top(j)=0;  
      end
  end
  if log10(mean(top))-pk.sig>0.1
      pks2(i).center=0;
  else
      pks2(i).center=1;
  end
end

pks_un=pks1(cellfun(@isempty,{pks1.Feature})); %unannotated pks in pks1
pks_met=pks1(strcmp({pks1.Feature},'Metabolite'));  % all Metabolites in pks1
pks_form=pks1(~cellfun(@isempty,{pks1.Formula})); % pks with formula
pks_form_Cshift=pks_form([pks_form.Cnum]==[pks_form.Cshift]);
pks_form_Cnat=pks_form([pks_form.Cnum]==[pks_form.Cnum_nat13]);


pks_POI=pks_un(~cellfun(@isempty,{pks_un.f2}));
for i=1:length(pks_POI)
    pks_POI(i).Formula=pks_POI(i).f2{1,1};
end

