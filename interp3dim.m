function imOut  = interp3dim( BW, nx,ny,nz)
% *************************************************************************
% function imOut  = interp3dim( BW, nx,ny,nz)
% *************************************************************************
%
% ABOUT:
% This function gives trilinear interpolation of 3D images.
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

im = double(BW);       
[y, x, z] = ndgrid(linspace(1,size(im,1),ny),...
          linspace(1,size(im,2),nx),...
          linspace(1,size(im,3),nz));

imOut=interp3(im,x,y,z,'*linear');