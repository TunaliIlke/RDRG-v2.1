function [RadGra, RadDev] = find_rad_dev_gra(V,cent,pxsz)
% *************************************************************************
%function [RadGra, RadDev] = find_rad_dev_gra(V,cent,pxsz)
% *************************************************************************
%
% ABOUT:
% This function gives radial gradient and radial deviation maps. 
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
% cent: 3D coordinate of center of mass respect to where the features are 
% going to be generated. --> exmp: cent = [125 126 33];
% pxsz: pixel spacing and slice thickness. For exmp: if slice thickness is
% 0.95 mm and slice thickness is 3 mm --> pxsz = [ 0.95 , 3 ];
%
%
% OUTPUT:
%
% RadGra: Radial gradient map
% RadDev: Radial deviation map
%
% HISTORY:
%
% Created: February 2017
% Version 2.1 (January 2018)
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************

if size(size(V),2) ==3 % If 3d image
  
    [Gx,Gy,Gz] = sobel3d(V,pxsz);
    Gtotal= [Gx(:) Gy(:) Gz(:)];
    [vecIx, vecIy,vecIz] = vec2center(V,cent);
    Vcent= [vecIx(:) vecIy(:) vecIz(:)];
    RadDev = zeros(size(V));
    RadGra = zeros(size(V));

else
    
    [Gx,Gy] = imgradientxy(V,'sobel');
    Gtotal= [Gx(:) Gy(:)];
    [vecIx, vecIy,~] = vec2center(V,cent);
    Vcent= [vecIx(:) vecIy(:) ];
    RadDev = zeros(size(V));
    RadGra = zeros(size(V));

end

for i=1:size(Vcent,1)
    
    p = Vcent(i,:);
    q = double(Gtotal(i,:));
    cross = dot (p,q) / (norm(q)*norm(p));
    rad = acos(cross);
    RadGra(i) = norm(q)*cos(rad);
    RadDev(i) = rad2deg(rad);
 
end

RadDev = 180 - RadDev;
RadGra = RadGra .* (-1);

if size(size(V),2) ==3 
   
    RadDev(cent(2),cent(1),cent(3))=0;
    RadGra(cent(2),cent(1),cent(3))=0;

else
    
    RadDev(cent(2),cent(1))=0;
    RadGra(cent(2),cent(1))=0;

end


    