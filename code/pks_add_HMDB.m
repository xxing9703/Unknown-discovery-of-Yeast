function pks=pks_add_HMDB(pks,settings)
dbase=table2struct(readtable('db_HMDB.csv'));
dbinfo=find_dbase_quick(dbase,pks,settings.ppm,settings.mode);
for i=1:length(pks)
    pks(i).HMDB=dbinfo(i);
end