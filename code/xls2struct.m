% read from .xlsx or .csv files, convert each sheet into a structure array.
% if only one sheet, use mystruct{1} to access the structure. otherwise,
% use mystruct{n}. 'sheets' returns the sheet names in cell array.

function [mystruct,sheets]=xls2struct(fname)
  if nargin==0
      [filename,filepath]=uigetfile('*.xlsx;*.csv');
      fname=fullfile(filepath,filename);
  end
  if ~exist(fname,'file')
      mystruct=0;
  else
    warning('off','all')
    [~,sheets,~]=xlsfinfo(fname);
    ct=0;
    for sh=1:length(sheets)
        if sh==1
          tp=readtable(fname);
        else
          tp=readtable(fname,'sheet',sheets{sh});
        end
        tp=table2struct(tp);  
        if ~isempty(tp)
             ct=ct+1;
             mystruct{ct}=tp;
        end
    end
  end
   if length(mystruct)==1
       mystruct=mystruct{1};
   end
 

