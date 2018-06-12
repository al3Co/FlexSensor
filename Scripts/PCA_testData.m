%% 260218 PCA data
close all
clear
clc
%% Read and categorice data
load('27B.mat')
load('27GF.mat')
load('27GS.mat')
load('27P.mat')
load('27PI.mat')

%% PCA principal component analysis of raw data
PCA_PlotFunc(B_IMU_27, GF_IMU_27, GS_IMU_27, P_IMU_27, PI_IMU_27);

%% all together
date = '27';
[Brazo, Espalda, IMUs] = loadDataTest(date);

Xint = [IMUs.A0 IMUs.A1 IMUs.A2 IMUs.A3 IMUs.A4];
Xext= [IMUs.A5 IMUs.A6 IMUs.A7 IMUs.A8 IMUs.A9];
[coeff,score,latent] = pca(Xext -mean(Xext));
[coeff2,score2,latent2] = pca(Xint - mean(Xint));


vblsExt = {'S_6','S_7','S_8','S_9','S_10'};
vblsInt = {'S_1','S_2','S_3','S_4','S_5'};

figure
subplot(2,1,1);
biplot(coeff(:,1:2),'score', score(:,1:2));
hold on
biplot(coeff(:,1:2),'varlabels', vblsExt);
title('Test all Data External sensors')

subplot(2,1,2);
biplot(coeff2(:,1:2),'score',score2(:,1:2),'varlabels',vblsInt);
hold on
biplot(coeff2(:,1:2),'varlabels', vblsInt);
title('Test all Data Internal sensors')

