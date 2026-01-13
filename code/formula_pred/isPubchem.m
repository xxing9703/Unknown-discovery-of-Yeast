function tf=isPubchem(formula)
try
     pyform=py.pubchempy.get_compounds(formula, 'formula');
     tf=length(pyform);
 catch
     tf=0;
 end
    