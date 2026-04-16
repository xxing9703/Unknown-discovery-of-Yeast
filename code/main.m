% main script
clear
pks=loadpks('..\results\pklist_SC_neg.csv'); %------------change
load('..\results\ispeak_SC_neg.mat');%------------change
load('..\results\M_neg.mat');
load('..\results\M_AIF_neg.mat');
load settings_neg
load rules_neg
M=M_SC; %------------change
M_AIF=M_SC_AIF; %------------change

% add ispeak
for i=1:length(pks)
  pks(i).ispeak=ispeak(i,:);
end

pks=pks_find_dup(pks,rules.dup.mz_tol,rules.dup.rt_tol);
pks=pks_cal_intens(pks,M,settings,2:4,5:7);
pks=pks_assign_artifact(pks,settings,rules);
pks=pks_add_AIF(pks,M_AIF,settings);
pks=pks_find_frag(pks,1.5,1e4,0.05);

% find good quality peaks
idx=[];
for i=1:length(pks)
    if sum(pks(i).ispeak)>=2
        idx=[idx,i];
    end
end

pks0=pks(idx); % all good peaks (at least 2/3 good peaks)
fc_thred = 10;
p_thred  = 0.1;

keep = zeros(1, length(pks0));
for i = 1:length(pks0)
    I = pks0(i).intens(2:7);   % [A1 A2 A3 B1 B2 B3]
    A = I(1:3);
    B = I(4:6);

    % fold change
    fc = mean(A) / mean(B);

    % t-test (log scale)
    [~, pval] = ttest2(A, B);
    % keep if pass criteria
    if fc >= fc_thred && pval > p_thred
        keep(i) = true;
    end
end
% filter pks
pks0 = pks0(keep==1);
pks1=pks0([pks0.sig]>5);
%pks=pks0(([pks0.sig]-[pks0.sig2])>1 & [pks0.sig]>5);
%%
pks=pks_add_Cinfo(pks,M,settings);
pks=pks_add_YMDB(pks,settings);
pks=pks_add_HMDB(pks,settings);
pks=pks_addms1_all(pks,M(2:4),settings);

pks=pks_addsig(pks,[M_IO(2:4),M_RT(2:4),M_SC(2:4)],settings);    


addpath('formula_pred')
load md_bgtree
pks=pks_addformulainfo(pks,md);

figure2

%%
addpath('deepmet');
pks=pks_add_deepmet(pks,settings);


%%
load ('..\results\ms2info_RT_kn.mat');
pks=pks_addms2info(pks,ms2info);
load ('..\results\ms2info_RT_un.mat');
pks=pks_addms2info(pks,ms2info);