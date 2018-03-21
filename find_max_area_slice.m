function [maxAreaSliceNum, Im] = find_max_area_slice(I)
% *************************************************************************
%[maxAreaSliceNum, Im] = find_max_area_slice(I)
% *************************************************************************
%
% ABOUT:
% This function finds the slice with maximum area of a 3D image. Returns
% the slice number with the maximum area and the image with only maximum
% area slice included.
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


maxAreaSliceNum = 1;
maxAreaSlice = 0;
for i = 1:size(I,3)
    
    L = logical(I(:,:,i),8);
    r = regionprops(L,'Area');
    area = [r.Area];
    
    if ~isempty (area) && area(1) >= maxAreaSlice
        maxAreaSlice = area(1);
        maxAreaSliceNum = i;
    end
        
end

Im = zeros(size(I));

Im(:,:,maxAreaSliceNum) = I (:,:,maxAreaSliceNum);