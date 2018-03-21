function features=feature_extraction(PBW,RadGra,RadDev,cent)
% *************************************************************************
% function features=feature_extraction(PBW,RadGra,RadDev,cent)
% *************************************************************************
%
% ABOUT:
% This function extract RD/RG features from radial gradient and radial 
% deviation maps given the center of segmentation mask.
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
% PBW: Binary mask image where the features are being generated.
% RadGra: Radial gradient map image
% RadDev: Radial deviation map image
% cent: center of mass to extract the 2D RD/RG features. The slice location
% of the center of mass is used to find 2D features.
%
% OUTPUT:
%
% features: RD/RG features generated.
%
% HISTORY:
%
% Created: February 2017
% Version 2.1 (January 2018)
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************

% if length(slices) ==1 
%    cent(3) = slices; 
% end

if size(size(PBW),2) == 2
    cent(3) = 1;
end
    
RadDev2D = RadDev(:,:,cent(3)); %for 2D features.
RadGra2D = RadGra(:,:,cent(3));
PBW2D = PBW(:,:,cent(3));

%% 3D Gradient Features


IRD = PBW.*RadDev;   % inside radial deviation;

IRD = IRD(IRD~=0 & ~isnan(IRD));

RDMI =  mean(IRD);   %radial deviation mean inside

RDSDI = std(IRD);    %radial deviation std. dev. inside

IRG = PBW.*RadGra;   % inside radial gradient;
IRG = IRG(IRG~=0 & ~isnan(IRG));


RGMI = mean(IRG);   %radial gradient mean inside
RGSDI = std(IRG);  %radial gradient std. dev. inside

GrFe = [RDMI,RDSDI,RGMI,RGSDI];

%% 2D Gradient Features

IRD2D = PBW2D.*RadDev2D;   % inside radial deviation;
IRD2D = IRD2D(IRD2D~=0 & ~isnan(IRD2D));


RDMI2D =  mean(IRD2D);   %radial deviation mean inside (2D)
RDSDI2D = std(IRD2D);    %radial deviation std. dev. inside (2D)

IRG2D = PBW2D.*RadGra2D;   % inside radial gradient;
IRG2D = IRG2D(IRG2D~=0 & ~isnan(IRG2D));

RGMI2D = mean(IRG2D);   %radial gradient mean inside
RGSDI2D = std(IRG2D); %radial gradient std dev mean inside

Gr2DFe = [RDMI2D,RDSDI2D,RGMI2D,RGSDI2D];% 2D Gradient Features

features = [GrFe,Gr2DFe];