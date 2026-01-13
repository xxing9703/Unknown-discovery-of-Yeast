function out=formula_classifier6r_v2(fm,md)
    [mz,~,ct]=formula2mass(fm);
    X=[ct(1:6),mz,ct(1)./ct(3),ct(2)./ct(3),ct(4)./ct(3),ct(5)./ct(3),ct(6)./ct(3),mz-round(mz),mod(round(mz),2)];
    out=md.predictFcn(X);
    if X(1)/X(3)<0.2 ||X(1)/X(3)>3
        out=0;
    elseif X(2)/X(3)>2
        out=0;
    elseif X(4)/X(3)>2
        out=0;
    elseif X(5)/X(3)>0.5
        out=0;
    elseif X(6)/X(3)>0.5
        out=0;
    end
    if prod(ismember(fm, 'CNHOSP0123456789'))==0
        out=0;
    end