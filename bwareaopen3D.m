function BWNew = bwareaopen3D(BW,n)
% *************************************************************************
% function BWNew = bwareaopen3D(BW,n)
% *************************************************************************
%
% ABOUT:
% Morphological opening in 3D for n size.
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

BWNew = zeros(size(BW));
for i = 1 : size(BW,3)
    
    BWNew(:,:,i) = bwareaopen(BW(:,:,i),n);

end
    