function stat=Cnum_get_stat(pkgrp,md)

stat = []; % zeros(length(pkgrp),3);
for i = 1:length(pkgrp)
    i
    pk = pkgrp(i);
    cnum  = pk.Cinfo.Cshift;
    tp1 = mass2formula_CN(pk.mz,[0,60],[0,12],3,-1);  % without cnum restriction
    tp2 = mass2formula_CN(pk.mz,[cnum,cnum],[0,12],3,-1); % with cnum restriction
    tp2a = formula_filter(tp2, md); % apply classifier
    stat(i,1) = size(tp1,1);
    stat(i,2) = size(tp2,1);
    stat(i,3) = size(tp2a,1);
end
stat(stat>10)=10;

% figure,
% subplot(3,1,1)
% histogram(stat(:,1));
% xlim([-1,11])
% subplot(3,1,2)
% histogram(stat(:,2));
% xlim([-1,11])
% subplot(3,1,3)
% histogram(stat(:,3));
% xlim([-1,11])
