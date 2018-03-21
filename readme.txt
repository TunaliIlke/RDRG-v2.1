[Feature_Values, Feature_Names] = extractRGRD(TmrMask,Im,Spacing,inter_size,maskLung)
% This function gives radial gradient and radial deviation radiomic
% features as an output. 
% 
% Please reference the below article if you use the features deriven by 
% this code.
%
% REFERENCE:
%
% [1] Tunali et al. (2017). "Radial gradient and radial deviation radiomic 
% features from pre-surgical CT scans are associated with survival among 
% lung adenocarcinoma patients". Oncotarget, 8:96013-26.
% doi:  https://doi.org/10.18632/oncotarget.21629
%

INPUTS: 

TmrMask: Tumor segmentation mask in binary format. 

Im: 3D medical image. (int 16 format) 

TmrMask and Im should be same size.

Spacing: Pixel spacing and slice thickness of the image. (ex: pixel spacing= 0.8685 and slice thickness = 2.5000, 
Spacing = [0.8685 2.500]. If the images are interpolated BEFORE, please put the interpolated spacing values.

inter_size: If interpolation is wanted to be done to the image inter_size should indicate what the interpolated size of the image should be. (ex: for 1mm X 1mm x 2mm spacing 
inter_size = [1 2])  
*If interpolation is not wanted inter_size = -1)

maskLung: Lung region mask in binary format. If lung mask is not available leave it blank. 

OUTPUTS:

Feature_Values: 48 RD/RG features extracted

Feature_Names: Names of the features extracted. 
