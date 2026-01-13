load('..\results\pks1_RT_deepmet_ms2.mat');
cats=[length(find([pks.cat]==1)),length(find([pks.cat]==2)),length(find([pks.cat]==3)),length(find([pks.cat]==4))];
fprintf([num2str(cats),'\n']);

load('..\results\pks1_IO_deepmet_ms2.mat');
cats=[length(find([pks.cat]==1)),length(find([pks.cat]==2)),length(find([pks.cat]==3)),length(find([pks.cat]==4))];
fprintf([num2str(cats),'\n']);

load('..\results\pks1_SC_deepmet.mat');
cats=[length(find([pks.cat]==1)),length(find([pks.cat]==2)),length(find([pks.cat]==3)),length(find([pks.cat]==4))];
fprintf([num2str(cats),'\n']);