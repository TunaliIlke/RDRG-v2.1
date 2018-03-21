function [vecIx, vecIy,vecIz] = vec2center(V,cent)
% *************************************************************************
% function [vecIx, vecIy,vecIz] = vec2center(V,cent)
% *************************************************************************
%
% ABOUT:
% This function creates image that has vectors from each pixel to center of
% the image.
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
% V: 3D image
% cent: 3D coordinate of center of mass respect to where the features are 
% going to be generated. --> exmp: cent = [125 126 33];
%
%
% OUTPUT:
%
% vecIx: Output vector's magnitude along x axis
% vecIy: Output vector's magnitude along y axis
% vecIz: Output vector's magnitude along z axis
% 
% HISTORY:
%
% Created: February 2017
% Version 2.1 (January 2018)
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************

siz = size(V);

if size(siz,2) < 3
    flag = 1; % if it is 2D image 
else
    flag = 0; % if it is 3D image 
end

vecIx = ones (siz);
vecIy = ones (siz);
vecIz = ones (siz);

r = regionprops(ones(siz),'PixelList','PixelIdxList');

list = [r.PixelList];
listIdx= [r.PixelIdxList];
list(:,1)= list(:,1)-cent(1);
list(:,2)= list(:,2)-cent(2);

if flag == 0  %3d image
    list(:,3)= list(:,3)-cent(3);
    vecIz (listIdx)= list(:,3);
end

vecIx (listIdx)= list(:,1);
vecIy (listIdx)= list(:,2);







