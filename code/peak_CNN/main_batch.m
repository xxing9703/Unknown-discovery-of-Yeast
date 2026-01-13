[fn,path]=uigetfile('*.mzXML',"MultiSelect","on");
fn=fullfile(path,fn);
[fn_pklist,path]=uigetfile('*.csv');
fn_pklist=fullfile(path,fn_pklist);
cols=[5,6];
model='net64';
ppm=5;
ave=5;
ispeak=[];
for i=1:length(fn)
   fn_mzXML=fn{i};
   ispeak(:,i)=peaksEVA(fn_mzXML,fn_pklist,cols,model,ppm,ave);
end