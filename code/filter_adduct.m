function pairs=filter_adduct(pairs_adduct,adduct)
% pairs=[];
% for i=1:length(pairs_adduct)
%     i
%     name=pairs_adduct(i).name;
%     ratio=pairs_adduct(i).ratio;
%     A=adduct(strcmp({adduct.name},name));
%     if ratio>A.ratio_lb && ratio<A.ratio_ub...
%          && abs(pairs_adduct(i).ppm)<A.ppm...
%          && abs(pairs_adduct(i).rtm)<A.rtm...
%         pairs=[pairs,pairs_adduct(i)];
%     end
%     
% end

 pairs=pairs_adduct;idx=[];
 for i=1:length(pairs_adduct)
    name=pairs_adduct(i).name;
    ratio=pairs_adduct(i).ratio;
    A=adduct(strcmp({adduct.name},name));
    if ratio>A.ratio_lb && ratio<A.ratio_ub...
         && abs(pairs_adduct(i).ppm)<A.ppm...
         && abs(pairs_adduct(i).rtm)<A.rtm...         
    else        
       idx=[idx,i];       
    end     
 end
 pairs(idx)=[];
