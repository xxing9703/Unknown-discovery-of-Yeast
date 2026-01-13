%this function requires that pubchempy is installed (python v3.10.11)
%go to pkg location, insert(py.sys.path,int32(0),pwd);
%"C:\Users\xxing\Documents\MATLAB\pubchempy-1.0.4-py_3\site-packages"

function pks=pks_addpubchem(pks)
for i=1:length(pks)
    i
    try
      pyform=py.pubchempy.get_compounds(pks(i).Formula, 'formula');
      for j=1:length(pyform)
        try
            pks(i).SMILES{j,1}=string(pyform{j}.isomeric_smiles);
        catch
            pks(i).SMILES{j,1}=[];
        end
        try
            pks(i).compound{j,1}=string(pyform{j}.iupac_name);
        catch
            pks(i).compound{j,1}=[];
        end
      end
    catch
    end
end
