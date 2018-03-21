function [Gx,Gy,Gz] = sobel3d(V,a)
% *************************************************************************
% function [Gx,Gy,Gz] = sobel3d(V,a)
% *************************************************************************
%
% ABOUT:
% This function gives the output of a Sobel 3D gradient filter. 
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
% INPUTS:
%
% V: 3D image
% a: pixel spacing and slice thickness. For exmp: if slice thickness is
% 0.95 mm and slice thickness is 3 mm --> pxsz = [ 0.95 , 3 ];
%
%
% OUTPUT:
%
% Gx: Gradient along x axis.
% Gy: Gradient along y axis.
% Gz: Gradient along z axis.
% 
% HISTORY:
%
% Created: February 2017
% Version 2.1 (January 2018)
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************


hz(:,:,1)=[-1 -2 -1; -2 -4 -2;-1 -2 -1];
hz(:,:,2)=[0 0 0; 0 0 0;0 0 0 ];
hz(:,:,3)=[1 2 1; 2 4 2;1 2 1 ];

hy(:,:,1) = [-1 -2 -1;0 0 0; 1 2 1];
hy(:,:,2) = [-2 -4 -2;0 0 0 ;2 4 2];
hy(:,:,3) = [-1 -2 -1;0 0 0; 1 2 1];

hx (:,:,1)= [-1 0 1;-2 0 2;-1 0 1];
hx (:,:,2)= [-2 0 2; -4 0 4;-2  0 2];
hx (:,:,3)= [-1 0 1 ; -2 0 2; -1 0 1];

if length(a) > 1
    
distmat(:,:,2) = [sqrt(a(1)^2 + a(1)^2) a(1) sqrt(a(1)^2 + a(1)^2); a(1) 1 a(1); sqrt(a(1)^2 + a(1)^2) a(1) sqrt(a(1)^2 + a(1)^2)];
distmat(:,:,1) = [sqrt(a(1)^2 + a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(1)^2 + a(2)^2 ); ...
    sqrt(a(1)^2 + a(2)^2 ) a(2) sqrt(a(1)^2 + a(2)^2 ); sqrt(a(1)^2 + a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(1)^2 + a(2)^2 )];
distmat(:,:,3) = [sqrt(a(1)^2 + a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(1)^2 + a(2)^2 ); ...
    sqrt(a(1)^2 + a(2)^2 ) a(2) sqrt(a(1)^2 + a(2)^2 ); sqrt(a(1)^2 + a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(2)^2 ) sqrt(a(1)^2 + a(1)^2 + a(2)^2 )];

hx = hx./distmat;
hy = hy./distmat;
hz = hz./distmat;
end

Gz = imfilter(V,hz,'replicate');
Gx = imfilter(V,hx,'replicate');
Gy = imfilter(V,hy,'replicate');
