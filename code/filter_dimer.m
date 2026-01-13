function pairs=filter_dimer(pairs_dimer,ratio)
pairs=[];
for i=1:length(pairs_dimer)
    r=pairs_dimer(i).ratio;
    if r>ratio
        pairs=[pairs,pairs_dimer(i)];
    end    
end