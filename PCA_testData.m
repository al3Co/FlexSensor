%% 260218 PCA data
close all
clear
clc
%% Read and categorice data

load('workSpaceSamperData.mat')


%% PCA principal component analysis of raw data

% <<<<<<< HEAD
Xint = [SDBF.A0 SDBF.A1 SDBF.A2 SDBF.A3 SDBF.A4];
Xext= [SDBF.A5 SDBF.A6 SDBF.A7 SDBF.A8 SDBF.A9];
[coeff,score,latent] = pca(zscore(Xext));
[coeff2,score2,latent2] = pca(zscore(Xint));
figure('Name', 'External sensors');
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_6','v_7','v_8','v_9','v10'});
figure('Name', 'Internal sensors');
biplot(coeff2(:,1:2),'scores',score2(:,1:2),'varlabels',{'v_1','v_2','v_3','v_4','v5'});


