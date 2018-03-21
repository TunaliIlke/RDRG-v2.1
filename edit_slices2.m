function NewBW = edit_slices2(BW,slices)
% *************************************************************************
% function NewBW = edit_slices2(BW,slices)
% *************************************************************************
%
% This function remove the slices that are not included on the slice list.
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

%

for i = 1:size(BW,3)
    
    if ~ismember(i,slices)
        
        BW(:,:,i) = 0;
    end
end
NewBW = BW;