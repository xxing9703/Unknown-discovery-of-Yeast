%% go to C:\Users\xxing\Documents\MATLAB\rdkit
% P = py.sys.path;
% if count(P,'rdkit') == 0
%     insert(P,int32(0),'rdkit');
% end
function plot_smiles(ax,smiles)
%smiles=pks1_RT(2).deepmetinfo(1).smiles{1};

Chem=py.importlib.import_module('rdkit.Chem'); %import rdkit
Draw=py.importlib.import_module('rdkit.Chem.Draw');
py.importlib.import_module('matplotlib.pyplot');
Mol=Chem.MolFromSmiles(smiles);
%formul=Chem.rdMolDescriptors.CalcMolFormula(Mol);
I=py.importlib.import_module('PIL'); %import PILLOW
img=Draw.MolToImage(Mol);
%imgdata=py.list(img.getdata());

imgdata=uint8(py.numpy.array(img));
imshow(double(imgdata)/256,'Parent',ax)


