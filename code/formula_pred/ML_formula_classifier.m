% this script creates training dataset for true&false molecular formulas
% load HMDB formula database, find m/z between 70 and 900

T=readtable('db_master.xlsx');
S=table2struct(T);  
S=S([S.mz]>70 & [S.mz]<900);

% formula filtering to contain only 6 elements: CNHOSP
idx=[];
for i=1:size(S,1)
  if prod(ismember(S(i).Formula, 'CNHOSP0123456789'))
      idx=[idx,i];
  end
end
S=S(idx);

% append atom numbers
for i=1:size(S,1)
    i
    formula=S(i).Formula;
    [mz,~,counts]=formula2mass(formula);
    xx(i,:)=counts;
    S(i).C=counts(1);
    S(i).N=counts(2);    
    S(i).H=counts(3);
    S(i).O=counts(4);
    S(i).S=counts(5);
    S(i).P=counts(6);   
end

formula_T=unique({S.Formula});  % unique true formulas
[~,B]=unique({S.Formula});
Su=S(B);
sort([Su.mz]);
unique_mz=sort([Su.mz]);
deltamz=unique_mz(2:end)-unique_mz(1:end-1);
%%
for i=1:length(unique_mz)
    i
    tp1=1;tp2=[];
    mz=unique_mz(i);
    ppm_limit=10*100/mz; 
    while isempty(tp2)
        tp1=1;
        while ~isempty(tp1)
            rd=rand(1);
            ppm_shift = rand(1)*1000-500; % a random ppm shift <100 ppm
            decoy_mz=unique_mz(i)*(1+ppm_shift*1e-6);
            tp1=find(abs(unique_mz(i)-decoy_mz)<ppm_limit*1e-6*decoy_mz); % if coincide with the known with ppm_limit
        end        
        tp2=mass2formula_CN(decoy_mz,[1,60],[0,12],ppm_limit,0);         
    end
    formula_F{i}=tp2(1,1);
end

%%

ct=0;formula_F=[];
for i=1:length(formula_T) 
    ct    
    [mz,~,counts]=formula2mass(formula_T{i});
    mz=mz+0.001+1e-5*mz; % shift mz by 0.001+10ppm to generate decoy
    tp1=mass2formula_CN(mz,[1,60],[0,12],1,0); %look for fake formulas of the decoy mz.
    if ~isempty(tp1)
        for j=1:size(tp1,1)
          if prod(ismember(tp1{j,1}, 'CNHOSP0123456789')) % retain fake formulas containing CNHOSP only
            ct=ct+1;
            formula_F{ct}=tp1{j,1};
            break
          end
        end        
    end
end
% S structure contains true formulas, F structure contains false formulas 

%%
dt_t=[];dt_f=[];
TT1=unique({S.Formula});  % True formulas
FF1=unique(F);  % Fake formulas

%formating data into dt containig 12 predictors and 1 response
for i=1:length(formula_T)
   [mz,~,counts]=formula2mass(formula_T{i});
   dt_t(i,1:6)=counts(1:6);
   dt_t(i,7)=mz;
   dt_t(i,8)=counts(1)/counts(3);
   dt_t(i,9)=counts(2)/counts(3);
   dt_t(i,10)=counts(4)/counts(3);
   dt_t(i,11)=counts(5)/counts(3);
   dt_t(i,12)=counts(6)/counts(3);
   dt_t(i,13)=mz-round(mz); %mass defect;
   dt_t(i,14)=mo(round(mz),2); %mass even odd;
   dt_t(i,15)=1;
end

for i=1:length(formula_F)
   [mz,~,counts]=formula2mass(formula_F{i});
   dt_f(i,1:6)=counts(1:6);
   dt_f(i,7)=mz;
   dt_f(i,8)=counts(1)/counts(3);
   dt_f(i,9)=counts(2)/counts(3);
   dt_f(i,10)=counts(4)/counts(3);
   dt_f(i,11)=counts(5)/counts(3);
   dt_f(i,12)=counts(6)/counts(3);
   dt_f(i,13)=mz-round(mz); %mass defect;
   dt_f(i,14)=mo(round(mz),2); %mass even odd;
   dt_f(i,15)=0;
end
dt_train=[dt_t;dt_f];  % all training data concatenated into DT

%%  ML on dt_train to generate a classification model

% run classifier learner app.

% fine tree model gives 95.



