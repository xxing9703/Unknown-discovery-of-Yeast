% subset pks for category 4 with plausible formula and extract their Cnum
% statistical plot for Cnum distribution across 3 yeast species
load ('..\results\pks1_SC_deepmet.mat')
mypks=pks([pks.cat]==4);
for i=1:length(mypks)
    if ~isempty(mypks(i).formulainfo)
      mypks(i).Cnum=mypks(i).Cinfo.Cshift; 
    else 
      mypks(i).Cnum=0;
    end
end

% change file name, run it same mypks-> mypks1,2,3  (Rt,Io,Sc)
% or load mypks123.mat to retrieve.  

%%
a=[mypks1.Cnum];
b=[mypks2.Cnum];
c=[mypks3.Cnum];

a(a==0)=[];
b(b==0)=[];
c(c==0)=[];

a(a<5)=0;b(b<5)=0;c(c<5)=0;
a(a>=5&a<10)=5;b(b>=5&b<10)=5;c(c>=5&c<10)=5;
a(a>=10&a<15)=10;b(b>=10&b<15)=10;c(c>=10&c<15)=10;
a(a>=15&a<20)=15;b(b>=15&b<20)=15;c(c>=15&c<20)=15;
a(a>=20)=20;b(b>=20)=20;c(c>=20)=20;


c1=[length(find(a==0)),length(find(a==5)),length(find(a==10)),length(find(a==15)),length(find(a==20))];
c2=[length(find(b==0)),length(find(b==5)),length(find(b==10)),length(find(b==15)),length(find(b==20))];
c3=[length(find(c==0)),length(find(c==5)),length(find(c==10)),length(find(c==15)),length(find(c==20))];

%%
figure
xx=[1,2,3,4,5];
plot(xx,c1,'-o','LineWidth',3);
hold on
plot(xx,c2,'-o','LineWidth',3);
hold on
plot(xx,c3,'-o','LineWidth',3);
xticks([1,2,3,4,5]);
xticklabels({'<5','5-10','10-15','15-20','>=20'});
xlabel('Carbon Number')
ylabel('Counts')
legend({'R. toruloides','I. orientalis','S. cerevisiae '})