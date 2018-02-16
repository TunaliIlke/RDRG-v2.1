% f_name2 = 'C:\Users\ilke\Desktop\DOI\Adenocarcinoma Subset'; %for laptop
clear all;clc ; close all;

f_name = '\\hlm\data\dept\CIM\Radiomics\Projects-Share\Prj_Immune\data\Pre-Scans';
f_name2 = 'F:\Projects\ImagestoExtractFeatures\pngsMATLAB\';
%f_name = 'X:\DOI\Adenocarcinoma Subset\R_013'; % for moffitt computer
dr = dir(f_name2);
infoo = cell(1);
exc = xlsread('LungFeaturesImTXforAnalyze.xlsx');
for jj = 1: length ( exc) %length(dr)-1
    
  
%   fTmr_masks = strcat(f_name2,dr(jj).name);
%   ID = num2str(dr(jj).name(1:6))
    ID = num2str(exc(jj,1));
    fTmr_masks = fullfile(f_name2,strcat(ID,'.',num2str(exc(jj,2)),'.LU.png'))

    [fts,infor] = featureCreationIMTX2 (ID,fTmr_masks);
    [infor] = findinfo(ID,fTmr_masks);
    
    
    fts(end+1) = str2num( ID);
%   if (dr(jj).name(8)) == '-'
%       fts(end+1) = str2num(dr(jj).name(8:9));
%   else
%       fts(end+1) = str2num(dr(jj).name(8));
%   end
%   features(jj-2,:) = fts;
    features(jj,:) = [fts exc(jj,2)];

%     infoo{jj-2,1} = infor{1};
%     infoo{jj-2,2} = infor{2};
    %infoo{jj-2,3} = infor{3};
    %infoo{jj-2,4}= infor{4};

end
    
    