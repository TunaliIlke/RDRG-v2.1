[Feature_Values, Feature_Names] = extractRGRD(TmrMask,Im,Spacing,inter_size,maskLung)

Inputs: 

TmrMask: Tumor Mask in binary format. 

Im: 3D medical image. (int 16 format) 

TmrMask and Im should be same size.

Spacing: Pixel spacing and slice thickness of the image. (ex: pixel spacing= 0.8685 and slice thickness = 2.5000, 
Spacing = [0.8685 2.500].If the images are interpolated BEFORE, please put the interpolated spacing values.

inter_size: If interpolation is wanted to be done to the image inter_size should indicate what the interpolated size of the image should be. (ex: for 1mm X 1mm x 2mm spacing 
inter_size = [1 2])  
*If interpolation is not wanted inter_size = -1)

maskLung: Lung region mask in binary format. If lung mask is not available leave it blank. 

Outputs:

Feature_Values: 48 RD/RG features extracted

Feature_Names: Names of the features extracted. 