%% 270218 ANN SensFlex PCA VS optiTrack
close all
clear
clc
%% load Data
load('BlueFront.mat');
[angM1, angM2, IMU] = funcAngOpti2(BRAZO, ESPALDA, SDBF);

%% cut wrong data 
ini = 137; fin = 1111;
BRAZO = BRAZO(ini:fin, 1:3);
ESPALDA = ESPALDA(ini:fin, 1:3);
IMU = IMU(ini:fin, 1:3);
angM1 = angM1(ini:fin, 1:1);
angM2 = angM2(ini:fin, 1:1);
SDBF = SDBF(ini:fin, 1:21);
%% filtering shoulder data
fk = funcFilter(angM2);

x = 1:length(angM1);
y = fk;
[p,~,mu] = polyfit(x, y, 45);
f = polyval(p,x,[],mu);

%% ANN Feedforward Neural Network

% feed
PCAs = [SDBF.A0 SDBF.A1 SDBF.A2 SDBF.A3 SDBF.A4 SDBF.A5 SDBF.A6 SDBF.A7 SDBF.A8 SDBF.A9];
X = [PCAs IMU]'; % INPUTS
T = [f']';

net = feedforwardnet(10,'trainlm'); % hiddenSizes
[net,tr] = train(net,X,T);
% view(net)
% % performance
y = net(X);
perf = perform(net,y,T);
% testing network
%output = net([1.429110992204339,-0.441761172331056,-0.200709853591719,1.85993595568572]); %100
% generate Function
genFunction(net,'ANN_OMI_Flex_VS_Shoulder_Fcn');
y2 = ANN_OMI_Flex_VS_Shoulder_Fcn(X);
accuracy = max(abs(y-y2));