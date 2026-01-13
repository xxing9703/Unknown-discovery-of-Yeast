function pks=pks_addstat(pks)

% add novelty catogory
for i=1:length(pks)
    if ~isempty(pks(i).Feature) 
        pks(i).cat=1;  %artifact
    elseif ~isempty(pks(i).YMDB.formula)
        pks(i).cat=2;  % YMDB
    elseif ~isempty(pks(i).HMDB.formula)
        pks(i).cat=3;  % HMDB
    else
        pks(i).cat=4;  % unannotated
    end
end

for i=1:length(pks)
  if  ~isempty(pks(i).YMDB.formula)
      pks(i).fYMDB=pks(i).YMDB.formula;
  end
  if  ~isempty(pks(i).HMDB.formula)
      pks(i).fHMDB=pks(i).HMDB.formula;
  end
  if  ~isempty(pks(i).formulainfo)
      pks(i).f1=pks(i).formulainfo{1,1};
      if size(pks(i).formulainfo,1)>1
        pks(i).f2=pks(i).formulainfo{2,1};  
      end
  end
  
end

