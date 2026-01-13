function [pks,cts]=pks_addms1info(pks,M,settings,iso)

if strcmp(iso,'13C')
    dmz=1.00335;
    abd=0.011;
    ub=50;
    minsig=2e4;
    pre='C';
elseif strcmp(iso,'18O')
    dmz=2.005;
    abd=0.00205;
    ub=20;
    minsig=2e4;
    pre='O';
elseif strcmp(iso,'34S')
    dmz=1.996;
    abd=0.0421;
    ub=5;
    minsig=2e4;
    pre='S';
elseif strcmp(iso,'37Cl')
    dmz=1.997;
    abd=0.33;
    ub=3;
    minsig=2e4; 
    pre='Cl';
elseif strcmp(iso,'10B')
    dmz=-0.996;
    abd=0.2;
    ub=6;
    minsig=2e4;
    pre='B';
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
       if sig1(j)>minsig
           tp(j)=sig1(j)/sig0(j)/abd;
       else
           tp(j)=nan;
       end
       if tp(j)>ub  % counts no more than ub;
           tp(j)=nan;
       end
    end
        
    pks(i).ms1info.info.([pre,'_max'])=round(max(tp));
    pks(i).ms1info.info.([pre,'_min'])=round(min(tp));
    pks(i).ms1info.info.([pre,'_med'])=round(median(tp,'omitnan'));    
    pks(i).ms1info.info.([pre,'_cts'])=length(tp)-sum(isnan(tp)); %valid count
    pks(i).ms1info.info.([pre,'_std'])=std(tp,'omitnan'); %valid count
    pks(i).ms1info.info.([pre,'_sigM0'])=median(sig0,'omitnan');
    pks(i).ms1info.info.([pre,'_sigM1'])=median(sig1,'omitnan');

    if pks(i).ms1info.info.([pre,'_cts'])>=1
      pks(i).ms1info.(['nat_',iso])=[num2str(pks(i).ms1info.info.([pre,'_med'])),'(',num2str(pks(i).ms1info.info.([pre,'_min'])),',',num2str(pks(i).ms1info.info.([pre,'_max'])),...
         ') ',num2str(pks(i).ms1info.info.([pre,'_cts'])),'/',num2str(length(tp)),' ',num2str(log10(pks(i).ms1info.info.([pre,'_sigM1'])),'%.1f')];
      cts=[pks(i).ms1info.info.([pre,'_min']), pks(i).ms1info.info.([pre,'_max'])];
    else
      pks(i).ms1info.(['nat_',iso])='NaN';
      cts=[0,0];
    end
        
end