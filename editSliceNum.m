function sliceNew = editSliceNum(slices)
% *************************************************************************
%function sliceNew = editSliceNum(slices)
% *************************************************************************
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

if length(slices)>5 && length(slices)< 10
    
    slices(1) =[];
    slices(end) = [];
    
elseif length(slices)>= 10
    slices(1:2) =[];
    slices(end) = [];
    slices(end) = [];
end

sliceNew = slices;
