function pks=pks_assign_artifact(pks,settings,rules)
adduct=xls2struct('adduct_list_neg_short.xlsx'); 
pksinfo.pairs_artifact=pks_find_ringing(pks,rules.arti.mz_tol,rules.arti.rt_tol,rules.arti.order);  %artifact - dppm based
pksinfo.pairs_adduct=pks_find_adduct(pks,adduct,rules.adduct.mz_tol,rules.adduct.rt_tol); %adduct/iso/multi  -mz diff based
pksinfo.pairs_dimer=pks_find_dimer(pks,rules.dimer.mz_tol,rules.dimer.rt_tol,settings.mode,2);  %dimer  -mz relationship based
   %pksinfo.formula=pks_find_dbase_quick(dbase,pks,rules.assign.mz_tol,settings.mode);
% apply additional filters
pksinfo.pairs_adduct=filter_adduct(pksinfo.pairs_adduct,adduct); %apply adduct ratio filterring rule
pksinfo.pairs_dimer=filter_dimer(pksinfo.pairs_dimer,rules.dimer.ratio); %apply dimer ratio fiterring rule
pksinfo=fix_dimer(pksinfo);

cat={'Artifact','Isotope','Adduct','Multicharge','Fragment','Dimer'};
pks=feature_assignment(pks,pksinfo,cat);




