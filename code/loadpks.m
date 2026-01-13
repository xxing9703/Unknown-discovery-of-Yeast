%load peaklist of (.csv) from MAVEN or (.xlsx) from XCMS
%usage pks=loadpks(); user select file(s) from file dialog
%pks=loadpks(fname1,fname2...)
function pks=loadpks(varargin)
if nargin==0
  [file,path]=uigetfile('*.csv;*.xlsx','MultiSelect','on');  %open fileselect dialog if no file input
  if isequal(file,0)
   disp('No files loaded');
   pks=[];
   return;
  end
  if ~iscellstr(file) % single file selected
        pks=readtable(fullfile(path,file));
  else  %multi files selected
        pks=readtable(fullfile(path,file{1}));
        for i=2:length(file)
            pks=[pks;readtable(fullfile(path,file{i}))];
        end
  end
elseif nargin==1
    if iscell(varargin{1})
        pklist=varargin{1};
        pks=readtable(pklist{1});
        pks=[pks;readtable(pklist{2})];
    else
      pks=readtable(varargin{1});
    end
elseif nargin>1
    pks=readtable(varargin{1});
       for i=2:nargin
            pks=[pks;readtable(varargin{i})];
       end 
end
t1=pks(:,strcmp(pks.Properties.VariableNames,'medMz'));
t2=pks(:,strcmp(pks.Properties.VariableNames,'medRt'));
t3=pks(:,strcmp(pks.Properties.VariableNames,'goodPeakCount'));
t4=pks(:,strcmp(pks.Properties.VariableNames,'maxQuality'));
T1=[t1,t2,t3,t4];

t1=pks(:,strcmp(pks.Properties.VariableNames,'mzmed'));
t2=pks(:,strcmp(pks.Properties.VariableNames,'rtmed'));
t3=pks(:,strcmp(pks.Properties.VariableNames,'npeaks'));
T2=[t1,t2,t3];


T=rmmissing([T1,T2]);
id=1:size(T,1);
T = addvars(T,id','Before',1);
T = addvars(T,id','Before',1);
T.Properties.VariableNames{1}='Index';
T.Properties.VariableNames{2}='id';
T.Properties.VariableNames{3}='mz';
T.Properties.VariableNames{4}='rt';
T.Properties.VariableNames{5}='npeaks';
  pks=table2struct(T);
%   for i=1:length(pks)
%     pks(i).feature='';
%   end