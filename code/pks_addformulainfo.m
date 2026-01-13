% based on Cinfo, add formulainfo
% need to load model by running:  "load md_finetree"
% addpath('formula_pred')

function pks=pks_addformulainfo(pks,md)
for n=1:length(pks)
    n
    formulainfo=[];
    Cshift=pks(n).Cinfo.Cshift;
    c=mass2formula_CN(pks(n).mz,[Cshift,Cshift],[0,12],3,-1); %3ppm, Ncount=0-12, negative mode
    if ~isempty(c)
        idx=[];
        for j=1:size(c,1)        
           tp=formula_classifier6r(c{j,1},md);
           if tp==1
               idx=[idx,j];
           end
        end
        if ~isempty(idx)
            formulainfo=c(idx,:);
        end
     end
   pks(n).formulainfo=formulainfo;
end