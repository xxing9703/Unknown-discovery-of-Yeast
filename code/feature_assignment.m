function pks=feature_assignment(pks,pksinfo,cat)
%define category in sequence, see example below
%cat={'Artifact','Background','Isotope','Adduct','Multicharge','Dimer','BuffSS','TimeSS','Fragment_CID'};


% assign isChild and isParent
for i=1:length(pks)
   pks(i).isChild=[]; 
   pks(i).isParent=[];
end
pairs=[pksinfo.pairs_adduct,pksinfo.pairs_dimer];
for i=1:length(pairs)
    idx=pairs(i).childIndex;
   pks(idx).isChild=[pks(idx).isChild,pairs(i)]; 
    idx2=pairs(i).parentIndex;
   pks(idx2).isParent=[pks(idx2).isParent,pairs(i)]; 
end

% concatenate adductnames
for i=1:length(pks)    
  if ~isempty(pks(i).isChild)  
    pks(i).adductname=strjoin({pks(i).isChild.name},'/');
  end
end

% assign all junks
junk=cat(:);
for i=1:length(junk)
   pks=feature_assign(pks,pksinfo,junk{i});
end
pks=feature_assign(pks,pksinfo,'Formula');
for i=1:length(pks)
    pks(i).Feature='';
    for j=1:length(junk)
        if ~isempty(pks(i).(junk{j}))&&isempty(pks(i).Feature)
            pks(i).Feature=junk{j};
        end
    end
    
    if ~isempty(pks(i).Formula)&&isempty(pks(i).Feature)
       pks(i).Feature='Metabolite'; 
    end
end