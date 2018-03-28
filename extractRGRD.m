function [Feature_Values, Feature_Names] = extractRGRD(TmrMask,Im,Spacing,inter_size,maskLung)
% *************************************************************************
% function [Feature_Values, Feature_Names] = extractRGRD(TmrMask,Im,Spacing,inter_size,maskLung)
% *************************************************************************
%
% ABOUT:
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
% INPUTS:
%
% TmrMask: Tumor Mask in binary format. 
% Im: 3D medical image (int 16 format)
% 
% TmrMask and Im should be the same size.
%
% Spacing: Pixel spacing and slice thickness of the image. (ex: pixel 
% spacing = 0.8685 and slice thickness = 2.5000, Spacing = [0.8685 2.500].
% If the images are interpolated BEFORE, please put the interpolated spacing values.
% 
% inter_size: If interpolation is wanted to be done to the image inter_size
% should indicate what the interpolated size of the image should be. 
% (ex: for 1mm X 1mm x 2mm spacing inter_size = % [1 2])  
% If interpolation is NOT needed put inter_size = -1.
%
% maskLung: Lung region mask in binary format. If lung mask is not 
% available leave it blank.
%
%
% OUTPUT:
%
% Feature_Values: 48 RD/RG features extracted.
% Feature_Names: Names of the features extracted. 
%
% Please read the readme.txt file for information on the usage of function.
% 
% For questions: <Ilke.Tunali@moffitt.org>
%
% HISTORY:
%
% Created: February 2017
% Version 2.1 (January 2018)
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************

if ~isequal(size(Im),size(TmrMask))
    error('Tumor Mask and Image should be the same size')
end

maskTmrAll = bwareaopen3D(TmrMask,8);
L = bwlabeln(maskTmrAll,26);
r1 = regionprops(L,'BoundingBox');
roundR1 = round(r1(1).BoundingBox);
range = [max([roundR1(3)-1 1]), min([roundR1(3)+roundR1(6), size(L,3)])];
maskTmr = maskTmrAll(:,:,range(1):range(2));
Im = Im(:,:,range(1):range(2));

r = regionprops(maskTmr,'centroid');
cent = [round(r.Centroid)];
sss = 75;

VOI = Im(max([cent(2)-sss,1]):min([512,cent(2)+sss]),max([1, cent(1)-sss]):min([cent(1)+sss,512]),:);
maskTmr = maskTmr(max([cent(2)-sss,1]):min([512,cent(2)+sss]),max([1, cent(1)-sss]):min([cent(1)+sss,512]),:);

VOI(VOI>=1024 ) = 1024;
VOI(VOI<=-1024) = -1024;
VOI = VOI./12;

[maskTmr,slices] = edit_slices(maskTmr);

foo = maskTmr(:,:,cent(3));
p = regionprops (foo,'MajorAxisLength');
pxSpac = Spacing(1);
maxDia = round(max([p.MajorAxisLength]).*pxSpac(1));

if isempty(maxDia)
    maxDia = 0;
end

[sEs1,sEs2] = find_str_elem(maxDia,pxSpac(1));

sz = size(maskTmr);

if exist('maskLung')
    LungMask = maskLung; t = 1;
    LungMask = LungMask(max([cent(2)-sss,1]):min([512,cent(2)+sss]),max([1, cent(1)-sss]):min([cent(1)+sss,512]),:);
else
    LungMask = ones(sz); t = 0;
end

maskOutside2 = outside_border(maskTmr,ones(sz),sEs2,1);
[maskBorder,maskErode] = outside_border2(maskTmr,LungMask,sEs1,t);

slices = editSliceNum(slices);

maskOutside2 = edit_slices2(maskOutside2,slices);
maskBorder = edit_slices2(maskBorder,slices);
maskErode = edit_slices2(maskErode,slices);
maskTmr = edit_slices2(maskTmr ,slices);


if inter_size ~= -1
    ratio = inter_size(1)/(pxSpac(1));
    ratio2 = inter_size(2)/Spacing(2);
    VOI = interp3dim(VOI, round(size(VOI,1)/ratio),round(size(VOI,2)/ratio),round(size(VOI,3)/ratio2));
    maskBorder = interp3dim(maskBorder, round(size(maskBorder,1)/ratio),round(size(maskBorder,2)/ratio),round(size(maskBorder,3)/ratio2))>0.20; 
    maskErode = interp3dim(maskErode, round(size(maskErode,1)/ratio),round(size(maskErode,2)/ratio),round(size(maskErode,3)/ratio2))>0.20; 
    maskTmr = interp3dim(maskTmr, round(size(maskTmr,1)/ratio),round(size(maskTmr,2)/ratio),round(size(maskTmr,3)/ratio2))>0.20; 
    maskOutside2 = interp3dim(maskOutside2, round(size(maskOutside2,1)/ratio),round(size(maskOutside2,2)/ratio),round(size(maskOutside2,3)/ratio2))>0.20; 
end

r = regionprops(maskTmr,'centroid');
cent = round(r.Centroid);
r = regionprops(maskTmr(:,:,cent(3)),'Area');
mx_area = max([r.Area]);

if maskTmr(:,:,cent(3)) == 0
    r = regionprops(maskTmr,'centroid');
    cent2 = round(r.Centroid);
else
    r = regionprops(bwareaopen(maskTmr(:,:,cent(3)),mx_area),'centroid');
    cent2 = round(r.Centroid);
    cent2(3) = cent(3);
end

if inter_size == -1
    [RadGra, RadDev] = find_rad_dev_gra(VOI,cent2,Spacing);
else
    [RadGra, RadDev] = find_rad_dev_gra(VOI,cent2,[inter_size(1) inter_size(2)]);
end


featuresTmr = feature_extraction(maskTmr,RadGra,RadDev,cent2);
featuresErode = feature_extraction(maskErode,RadGra,RadDev,cent2);
featuresOutside2 = feature_extraction(maskOutside2,RadGra,RadDev,cent2);
featuresBorder = feature_extraction(maskBorder,RadGra,RadDev,cent2);


Feature_Values = [featuresTmr featuresErode featuresBorder featuresOutside2...
    (featuresOutside2-featuresTmr)./(featuresOutside2+featuresTmr)...
    (featuresOutside2-featuresBorder)./(featuresOutside2+featuresBorder) ...
    ]; 

Feature_Names = {'radial deviation tumor mean'	'radial deviation tumor SD' 'radial gradient tumor mean' 	'radial gradient tumor SD'	'radial deviation tumor mean (2D)'	'radial deviation tumor SD (2D)'	'radial gradient tumor mean (2D)'	'radial gradient tumor SD (2D)'	'radial deviation core mean'	'radial deviation core SD' 	'radial gradient core mean' 	'radial gradient core SD'	'radial deviation core mean (2D)'	'radial deviation core SD (2D)'	'radial gradient core mean (2D)'	'radial gradient core SD (2D)'	'radial deviation border mean'	'radial deviation border SD' 	'radial gradient border mean' 	'radial gradient border SD'	'radial deviation border mean (2D)'	'radial deviation border SD (2D)'	'radial gradient border mean (2D)'	'radial gradient border SD (2D)'	'radial deviation outside mean'	'radial deviation outside SD' 	'radial gradient outside mean' 	'radial gradient outside SD'	'radial deviation outside mean (2D)'	'radial deviation outside SD (2D)'	'radial gradient outside mean (2D)'	'radial gradient outside SD (2D)'	'radial deviation outside-tumor seperation mean'	'radial deviation outside-tumor seperation SD' 	'radial gradient outside-tumor seperation mean' 	'radial gradient outside-tumor seperation SD'	'radial deviation outside-tumor seperation mean (2D)'	'radial deviation outside-tumor seperation SD (2D)'	'radial gradient outside-tumor seperation mean (2D)'	'radial gradient outside-tumor seperation SD (2D)'	'radial deviation outside-border seperation mean'	'radial deviation outside-border seperation SD' 	'radial gradient outside-border seperation mean' 	'radial gradient outside-border seperation SD'	'radial deviation outside-border seperation mean (2D)'	'radial deviation outside-border seperation SD (2D)'	'radial gradient outside-border seperation mean (2D)'	'radial gradient outside-border seperation SD (2D)' };




