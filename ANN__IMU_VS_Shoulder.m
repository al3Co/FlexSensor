% 260218 ANN IMU VS SHOULDER
close all
clear
clc
%% Read and categorice data
load('BlueFront.mat')
[angM1, angM2, IMU] = funcAngOpti2(BRAZO, ESPALDA, SDBF);

%% cut wrong data 
ini = 137; fin = 1111;      % data without movement or wrong data
BRAZO = BRAZO(ini:fin, 1:3);
ESPALDA = ESPALDA(ini:fin, 1:3);
IMU = IMU(ini:fin, 1:3);
angM1 = angM1(ini:fin, 1:1);
angM2 = angM2(ini:fin, 1:1);
SDBF = SDBF(ini:fin, 1:21);
%% filtering shoulder data
fk = funcFilter(angM2);         % kalman filter
x = 1:length(angM1);            % polyfit func
y = fk;
[p,~,mu] = polyfit(x, y, 45);
f = polyval(p,x,[],mu);
%% ANN Feedforward Neural Network

% feed
X = [IMU]'; % INPUTS
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
genFunction(net,'ANN_IMU_VS_Shoulder_Fcn');
y2 = ANN_IMU_VS_Shoulder_Fcn(X);
accuracy = max(abs(y-y2));

