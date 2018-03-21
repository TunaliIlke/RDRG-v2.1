function BW =outside_border(maskTmr,maskLung,sE,t)
% *************************************************************************
%function BW =outside_border(maskTmr,maskLung,sE,t)
% *************************************************************************
%
% ABOUT:
% This function finds  the outside border of the lesion ROI.
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

s = strel('disk',sE);
BW = imdilate(maskTmr,s);
BW = BW.*maskLung;
if t == 1 % make donut or not
    BW = BW-maskTmr;
end
BW = BW == 1;
