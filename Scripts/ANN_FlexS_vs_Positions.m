%% 270218 ANN SensFlex VS IMU
close all
clear
clc

%% Data
% day = '27';
% [Brazo, Espalda, IMUs] = loadDataTest(day);
load('27PI_Match.mat');

%% angle BTW Shoulder and Back
%[angM1, angM2, brazoPos, IMUang, IMUQ] = funcAngOpti2(Brazo, Espalda, IMUs);

%% filtering shoulder data
%[fk, f] = funcFilter(angM2);
%plot([angM2, fk', f'])

%% ANN Feedforward Neural Network
% feed
%X = [IMUs.A0 IMUs.A1 IMUs.A2 IMUs.A3 IMUs.A4 IMUs.A5 IMUs.A6 IMUs.A7 IMUs.A8 IMUs.A9]'; % INPUTS
X = [tableSensorsData.A0 tableSensorsData.A1 tableSensorsData.A2 tableSensorsData.A3 tableSensorsData.A4 ...
    tableSensorsData.A5 tableSensorsData.A6 tableSensorsData.A7 tableSensorsData.A8 tableSensorsData.A9]'; % INPUTS
%T = [Brazo Espalda]';
%T = [tableMatched.aBrazoX tableMatched.aBrazoY tableMatched.aBrazoZ]';
T = [tableMatched.angBrazoX tableMatched.angBrazoY tableMatched.angBrazoZ]';

net = feedforwardnet(30); % hiddenSizes
[net,tr] = train(net,X,T);
% view(net)
% % performance
y = net(X);
perf = perform(net,y,T);
% testing network
%output = net([1.429110992204339,-0.441761172331056,-0.200709853591719,1.85993595568572]); %100
% generate Function
genFunction(net,'ANN_SensF_vs_IMU_Fcn');
y2 = ANN_SensF_vs_IMU_Fcn(X);
accuracy = max(abs(y-y2)');
accuracy = max(accuracy)
