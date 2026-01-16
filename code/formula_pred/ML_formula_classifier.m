% this script creates training dataset for true&false molecular formulas
% load HMDB formula database, find m/z between 70 and 900
addpath('..\')
T=readtable('..\db_HMDB.csv');
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
%% create decoy m/z
% ct=0; ii=randperm(7747);
% for i=1:4000   
%     fprintf([num2str(i),'  ',num2str(ct),'\n']);
%     tp1=1;tp2=[];
%     mz=unique_mz(ii(i));
%     if mz<118        
%     else
%         ppm_limit=10*100/mz; 
%         while isempty(tp2)
%             tp1=1;
%             while ~isempty(tp1)
%                 rd=rand(1);
%                 ppm_shift = rand(1)*1000-500; % a random ppm shift <100 ppm
%                 decoy_mz=mz*(1+ppm_shift*1e-6);
%                 tp1=find(abs(mz-decoy_mz)<ppm_limit*1e-6*decoy_mz); % if coincide with the known with ppm_limit
%             end   
%             tp2=mass2formula_CN(decoy_mz,[0,60],[0,12],ppm_limit,0); 
%             for k=1:min(size(tp2,1),2)
%                  %tf=isPubchem(tp2(k,1));  
%                  if 1
%                     ct=ct+1;
%                     formula_F{ct}=tp2(k,1);                 
%                  end
%             end
%         end 
%     end
% end

%

ct=0;formula_F=[];
for i=1:length(formula_T) 
    [i,ct]    
    [mz,~,counts]=formula2mass(formula_T{i});
    mz=mz + (2*randi([0, 1])-1)*((10+rand*90)*1e-6*mz); % shift mz by 10-100ppm to generate decoy
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
%S structure contains true formulas, F structure contains false formulas 

%% append predictors
dt_t=[];dt_f=[];

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
   dt_t(i,14)=mod(round(mz),2); %mass even odd;
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
   dt_f(i,14)=mod(round(mz),2); %mass even odd;
   dt_f(i,15)=0;
end
dt_train=[dt_t;dt_f];  % all training data concatenated into DT

%%  ML on dt_train to generate a classification model

% run classifier learner app.

% fine tree model gives 95.


%%

figure, 

subplot(2,3,1)
plot(dt_t(:,7),dt_t(:,1),'.')
xlabel('m/z')
ylabel('C counts')

subplot(2,3,2)
plot(dt_t(:,7),dt_t(:,2),'.')
xlabel('m/z')
ylabel('N counts')

subplot(2,3,3)
plot(dt_t(:,7),dt_t(:,3),'.')
xlabel('m/z')
ylabel('H counts')

subplot(2,3,4)
plot(dt_t(:,7),dt_t(:,4),'.')
xlabel('m/z')
ylabel('O counts')

subplot(2,3,5)
plot(dt_t(:,7),dt_t(:,5),'.')
xlabel('m/z')
ylabel('S counts')

subplot(2,3,6)
plot(dt_t(:,7),dt_t(:,6),'.')
xlabel('m/z')
ylabel('P counts')

% find even/odd
find(mod(dt_t(:,2),2)==dt_t(:,14))
find(mod(dt_f(:,2),2)==dt_f(:,14))

 figure, histogram(dt_t(:,13))








