function [NewBW,slices] = edit_slices (BW)
% *************************************************************************
%function [NewBW,slices] = edit_slices (BW)
% *************************************************************************
%
% ABOUT:
% Remove first and last slides of medical image for reducing partial
% volume effect.
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
% For questions: <Ilke.Tunali@moffitt.org>
%
% HISTORY:
%
% Created: February 2017
% Version 2.1 (January 2018)
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************

n = 25;
BW2 = bwareaopen3D(BW,n);
slices =[];
for j = 1: size (BW2,3)
    
    foo = BW2(:,:,j);
    if any(foo(:),1)
        slices = [slices ,j];
    end
end
if isempty(slices)
    slices = find_max_area_slice(BW);
    BW2(:,:,slices) = BW(:,:,slices);
end
if length(slices)> 3
    BW2(:,:,slices(1)) = 0;
    BW2(:,:,slices(end)) = 0;
    NewBW = BW2;
    slices(1) = [];
    slices(end) = [];
else
    NewBW = zeros(size(BW2));
    for q = 1:length(slices)
        sz(q) = sum(sum(BW2(:,:,slices(q))));
    end
    if length (sz) > 1
        
        cent = round(size(slices,2)/2 );
        slices = slices(cent);
        NewBW = zeros(size(BW));
        NewBW(:,:,slices) = BW2(:,:,slices);

    else
    NewBW = bwareaopen3D(BW2,max(sz));
    [~,ix] = max(sz);
    slices = slices(ix);
    end
end