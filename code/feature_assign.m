function pks=feature_assign(pks,pksinfo,cat)

 for i=1:length(pks)
      pks(i).(cat)='';    
 end
if strcmp(cat,'Artifact') && isfield(pksinfo,'pairs_artifact')
    for i=1:length(pksinfo.pairs_artifact)
        pks(pksinfo.pairs_artifact(i).childIndex).(cat)=cat;    
    end 
elseif strcmp(cat,'Background') && isfield(pksinfo,'BLK')
    for i=1:length(pksinfo.BLK)
        if pksinfo.BLK(i).flag==1
          pks(pksinfo.BLK(i).Index).(cat)=cat;   
        end
    end   
elseif strcmp(cat,'NonBio') && isfield(pksinfo,'CN')
    for i=1:length(pksinfo.CN)
        if isempty(pksinfo.CN(i).C)
            pks(pksinfo.CN(i).Index).(cat)=cat; 
        else
            if pksinfo.CN(i).C==0
                pks(pksinfo.CN(i).Index).(cat)=cat; 
            end
        end
    end
elseif strcmp(cat,'Fragment_CID') && isfield(pksinfo,'CID')   
    for i=1:length(pksinfo.CID)
        if pksinfo.CID(i).flag==1
          pks(pksinfo.CID(i).Index).(cat)=cat; 
        end
    end
elseif strcmp(cat,'Adduct')||strcmp(cat,'Isotope')||strcmp(cat,'Multicharge')...
        ||strcmp(cat,'Dimer')||strcmp(cat,'Fragment')
    for i=1:length(pks)
    A=pks(i).isChild;
        if ~isempty(A)
            for k=1:length(A)  
               if strcmp({A(k).feature},cat)
                  pks(i).(cat)=cat;
               end
            end     
        end    
    end
elseif strcmp(cat,'BuffSS')&& isfield(pksinfo,'BUFF')
    for i=1:length(pksinfo.BUFF)
        if pksinfo.BUFF(i).flag==1
          pks(pksinfo.BUFF(i).Index).(cat)=cat;   
        end
    end
elseif strcmp(cat,'TimeSS')&& isfield(pksinfo,'time')
    for i=1:length(pksinfo.time)
        if pksinfo.time(i).flag==1
          pks(pksinfo.time(i).Index).(cat)=cat;   
        end
    end
elseif strcmp(cat,'Low_C')&& isfield(pksinfo,'Low_C')
    for i=1:length(pksinfo.Low_C)
        pks(pksinfo.Low_C(i).Index).(cat)=cat;   
    end
elseif strcmp(cat,'Odd_N')&& isfield(pksinfo,'Odd_N')
    for i=1:length(pksinfo.Odd_N)
        pks(pksinfo.Odd_N(i).Index).(cat)=cat;   
    end
elseif strcmp(cat,'Formula')&& isfield(pksinfo,'formula')
    for i=1:length(pksinfo.formula)
        pks(pksinfo.formula(i).Index).(cat)=pksinfo.formula(i).formula;
        pks(pksinfo.formula(i).Index).Name=pksinfo.formula(i).formulaName; %added 11/13/2020
    end    
end
