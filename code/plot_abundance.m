% required: run pks_addsig to pks
% plot statistical summary for yeast abundance of selected pk, 
function ax=plot_abundance(ax,pk)
S(1)=pk.SC_12C_01;
S(2)=pk.SC_12C_02;
S(3)=pk.SC_12C_03;
S(4)=pk.RT_12C_01;
S(5)=pk.RT_12C_02;
S(6)=pk.RT_12C_03;
S(7)=pk.IO_12C_01;
S(8)=pk.IO_12C_02;
S(9)=pk.IO_12C_03;
boxplot(ax,reshape(S,3,3))
xticklabels(ax,{'S.c','R.t','I.o'})
