function [BWOut,BWErode] =outside_border2(maskTmr,maskLung,sE,t)
% *************************************************************************
% function [BWOut,BWErode] =outside_border2(maskTmr,maskLung,sE,t)
% *************************************************************************
%
% ABOUT:
% This function finds the immediate border region of the lesion ROI.
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

s = strel('disk',sE); % SE = 3
BW = imdilate(maskTmr,s);
s = strel('disk',sE+2); % SE = 5
BWErode = imerode(maskTmr,s);
BW2 = BW-BWErode;
if t == 1 % For masking with lung region.
    BW2 = BW2.*maskLung;
end
BWOut = BW2 == 1;
