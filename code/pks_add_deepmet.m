function pks=pks_add_deepmet(pks,settings)
dmet=readtable('unique-masses-novel-1.tsv',"FileType","text",'Delimiter', ',');
for i=1:length(pks)
    i
    pk=pks(i);
    mz=pk.mz+1.00728;
    ids=find(abs(mz-dmet{:,2})<mz*settings.ppm);
    sub=dmet(ids,:);
    if ~isempty(sub) 
        n=min(size(sub,1),5);
        deepmetinfo=[];
        for j=1:n 
            deepmetinfo(j).smiles=sub{j,1};
            deepmetinfo(j).mass=sub{j,2};
            deepmetinfo(j).formula=sub{j,3};
            deepmetinfo(j).score=sub{j,4};
            try
                out=chemtrans(sub{j,1},'stdinchikey');
                tp=out{2,2};
                tp=split(tp,'=');
                tp=tp{2};
                deepmetinfo(j).inchi=tp;
            catch
            end
        end
        pks(i).deepmetinfo=deepmetinfo;
    end  
end
