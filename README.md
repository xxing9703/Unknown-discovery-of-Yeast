# Unknown-discovery-of-Yeast

**Yeast Untargeted Metabolomics Peak Annotation and Analysis Pipeline tailored for unknown metabolite discovery**

This repository contains the main **MATLAB** code pipeline for processing untargeted LC-MS metabolomics data from yeast. The pipeline includes the following steps:

- Extract peak intensities across datasets.  
- Annotate isotopes, adducts, in-source fragment (using additional AIF data) and other redundencies.
- Extract carbon information from isotopic data.  
- Assign molecular formulas based on carbon information.  
- Match formulas against HMDB/YMDB databases.  
- Integrate MS1 and MS2 information.  
- Combine all results into a structured, analysis-ready data table in "pks"
## Dataset

The raw **mzXML** data supporting this work has been deposited to Figshare and is available at:  
[Untargeted Metabolomics Dataset for Yeast](https://figshare.com/articles/dataset/Untargeted_metabolomics_dataset_for_Yeast/31061701)

The file **`M_neg.mat`** contains the parsed data ready to be loaded in MATLAB.  Please download and place it in the `results` folder before running "main.m" 



