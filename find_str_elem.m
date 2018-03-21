function [sEs1,sEs2] = find_str_elem(maxDia,pxSpac)
% *************************************************************************
% function [sEs1,sEs2] = find_str_elem(maxDia,pxSpac)
% *************************************************************************
%
% ABOUT:
% This function finds structral elements being used for finding the border 
% and outside maps. 
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

if maxDia >25 && maxDia <= 50
    sEs1 = round(2.5/pxSpac);
    sEs2 = round(5.5/pxSpac);
elseif maxDia > 50
    sEs1 = round(3.5/pxSpac);
    sEs2 = round(7.5/pxSpac);
else
    sEs1 = round(1.5/pxSpac);
    sEs2 = round(4.0/pxSpac);
end
