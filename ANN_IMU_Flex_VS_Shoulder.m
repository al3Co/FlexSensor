%% 270218 ANN IMU + SensFlex VS optiTrack
close all
clear
clc

%% load Data
load('26B.mat');
load('26GF.mat');
load('26GS.mat');
load('26P.mat');
load('26PI.mat');

%% concatenate arrays
Brazo = cat(1, BrazoBlue, BrazoGF, BrazoGS, BrazoP, BrazoPINV);
Espalda = cat(1, EspaldaBlue, EspaldaGF, EspaldaGS, EspaldaP, EspaldaPINV);
IMUs = cat(1, B_IMU_26, GF_IMU_26, GS_IMU_26, P_IMU_26, PI_IMU_26);

%% 
[angM1, angM2, IMU] = funcAngOpti2(Brazo, Espalda, IMUs);


%% filtering shoulder data
fk = funcFilter(angM2);

x = 1:length(angM1);
y = fk;
[p,~,mu] = polyfit(x, y, 45);
f = polyval(p,x,[],mu);

% %% ANN Feedforward Neural Network
% 
% % feed
% X = [SDBF.A0 SDBF.A1 SDBF.A2 SDBF.A3 SDBF.A4 SDBF.A5 SDBF.A6 SDBF.A7 SDBF.A8 SDBF.A9 IMU]'; % INPUTS
% T = [f']';
% 
% net = feedforwardnet(10,'trainlm'); % hiddenSizes
% [net,tr] = train(net,X,T);
% % view(net)
% % % performance
% y = net(X);
% perf = perform(net,y,T);
% % testing network
% %output = net([1.429110992204339,-0.441761172331056,-0.200709853591719,1.85993595568572]); %100
% % generate Function
% genFunction(net,'ANN_OMI_Flex_VS_Shoulder_Fcn');
% y2 = ANN_OMI_Flex_VS_Shoulder_Fcn(X);
% accuracy = max(abs(y-y2));