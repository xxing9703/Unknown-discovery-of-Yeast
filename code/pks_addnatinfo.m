function pks=pks_addnatinfo(pks,M,settings,iso)

if strcmp(iso,'13C')
    dmz=-1.00335;
    abd=0.011;
    ub=0.8;
   % minsig=3e5;
    pre='C';
elseif strcmp(iso,'18O')
    dmz=-2.005;
    abd=0.00205;
    ub=5;
    %minsig=3e5;
    pre='O';
elseif strcmp(iso,'34S')
    dmz=-1.996;
    abd=0.0421;
    ub=5;
    %minsig=3e5;
    pre='S';
elseif strcmp(iso,'37Cl')
    dmz=-1.997;
    abd=0.33;
    ub=1;
    %minsig=3e5; 
    pre='Cl';
elseif strcmp(iso,'Na')
    dmz=-21.982;
    abd=0.01;
    ub=5;
    %minsig=3e5; 
    pre='Na';
elseif strcmp(iso,'10B')
    dmz=0.996;
    abd=0.2;
    ub=6;
    %minsig=3e5;
    pre='B';
elseif strcmp(iso,'dbl')
    dmz=1.00335/2;
    abd=0.01;
    ub=0.1;
    %minsig=3e5; 
    pre='dbl';
 elseif strcmp(iso,'13Cdbl')
    dmz=-1.00335/2;
    abd=0.01;
    ub=1;
    %minsig=3e5; 
    pre='dbl13C';
end


rtw=0.05;
for i=1:length(pks) 
    i
    pk=pks(i);
    [~,sig0,rt_fix]=EIC(M,pk,settings);
    pk.rt=rt_fix; 
    settings.rtm=rtw;
    %------- 13C
    pk.mz=pks(i).mz+dmz;
    pk.rt=median(rt_fix);
    [~,sig1,rt_fix]=EIC(M,pk,settings);
    for j=1:length(sig0)
       if sig1(j)>sig0(j)*ub
           tp(j)=sig0(j)/sig1(j)/abd;
       else
           tp(j)=nan;
       end
    end
        
    pks(i).natinfo.info.([pre,'_max'])=round(max(tp));
    pks(i).natinfo.info.([pre,'_min'])=round(min(tp));
    pks(i).natinfo.info.([pre,'_med'])=round(median(tp,'omitnan'));    
    pks(i).natinfo.info.([pre,'_cts'])=length(tp)-sum(isnan(tp)); %valid count
    pks(i).natinfo.info.([pre,'_std'])=std(tp,'omitnan'); %valid count
    pks(i).natinfo.info.([pre,'_sigM0'])=median(sig0,'omitnan');
    pks(i).natinfo.info.([pre,'_sigM1'])=median(sig1,'omitnan');

    if pks(i).natinfo.info.([pre,'_cts'])>=3
       pks(i).natinfo.(['is',iso])=['Y, ',num2str(pks(i).natinfo.info.([pre,'_cts'])),'/',num2str(length(tp)),' ',num2str(pks(i).natinfo.info.([pre,'_med']))];
    else
      pks(i).natinfo.(['is',iso])='N';
    end
        
end