function output=mass2formula_CN(mass,C_num,N_num,ppm,polar)
if nargin<5
    polar=0;
end
st=0;

C_lb = min(C_num);
C_ub = min(max(C_num), floor(mass*20/300+3));
H_ub = min(floor(mass*52/400+5),120);

elem={
   % 'C',12,min(C_num),max(C_num);... %input
    'C',12,C_lb,C_ub;... %input
    'H',1.007825,0,H_ub;...  %used to be 100
    'N',14.003074,min(N_num),max(N_num);... %input
    'O',15.994915,0,30;...
    'P',30.973763,0,8;...
    'S',31.972072,0,8;...
    'Cl',34.968853,0,0;...  %used to be 1
    %'Na',22.98976928,0,1;...
    %'Si',27.9769265325,0,1;...
    %'K',38.96370668,0,1;...    
    %'Cr',51.9405075,0,1;
    };

%H=1.00783;
H=1.007276466879;

mass=mass-H*polar;


%ppm=5;
ppm=ppm/1e6;

lo=mass*(1-ppm);
hi=mass*(1+ppm);
cutoff=mass;
pos=size(elem,1);   
ppp=1:pos;

[~,ordering]=sort(cell2mat(elem(:,2)));


elem=elem(ordering,:);


%[combo]=get_mass_combos(elem, pos, lo, hi, cutoff);
[combo]=get_mass_combos2(cell2mat(elem(:,2:end)), mass,mass*ppm);
if isempty(combo)
    output=[];
    return
end

combo=combo(:,ppp(ordering));
elem=elem(ppp(ordering),:);
%fprintf([num2str(size(combo,1)),' formulars found\n']);

%%
% filter C-H-N-O-P-S-Cl
tp=[];
for i=1:size(combo,1)
   if 0%combo(i,1)>elem{1,4}  %C number > limit setting
      
   elseif combo(i,2)>combo(i,1)*4+combo(i,3)*3+combo(i,4)*2+combo(i,5)*5+combo(i,6)*2 %too much H      
   
   % elseif mod(combo(i,2),2)~=mod(combo(i,3)+combo(i,5)+combo(i,7),2)  %unsatuation
      
   else
       tp=[tp,i];
   end
   %tp=[tp;combo(i,:)];  
    
end
%combo=tp;
%%
combo=combo(tp,:);


name=[];
for i=1:size(combo,1)
    name{i}=[];
    for j=1:size(combo,2)
      if combo(i,j)>0
        name{i}=[name{i},elem{j}];
        if combo(i,j)>1
         name{i}=[name{i},num2str(combo(i,j))];
        end
      end
    end
end
name=name';

mz=[]';
for i=1:length(name)
  mz(i)=formula2mass(name{i});
end

[~,b]=sort(abs(mz-mass));
output=[name(b),num2cell(mz(b)'),num2cell((mz(b)'-mass)/mass*1e6)];
