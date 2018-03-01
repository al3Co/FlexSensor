%% 270218 ANN IMU + SensFlex VS optiTrack
close all
clear
clc

%% Data
day = '27';
[Brazo, Espalda, IMUs] = loadDataTest(day);

%% angle BTW Shoulder and Back
[angM1, angM2, brazoPos, IMUang] = funcAngOpti2(Brazo, Espalda, IMUs);

%% filtering shoulder data
[fk, f] = funcFilter(angM2);
%plot([angM2, fk', f'])

%% ANN Feedforward Neural Network
% feed
X = [IMUs.A0 IMUs.A1 IMUs.A2 IMUs.A3 IMUs.A4 IMUs.A5 IMUs.A6 IMUs.A7 IMUs.A8 IMUs.A9 ]'; % INPUTS
% T = [f']';
T = [IMUang]';

net = cascadeforwardnet(10); % hiddenSizes
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

%% comp

load('allData26.mat')

IMUdata26 = [IMUs26.A0 IMUs26.A1 IMUs26.A2 IMUs26.A3 IMUs26.A4 IMUs26.A5 IMUs26.A6 IMUs26.A7 IMUs26.A8 IMUs26.A9];
[angM1C, angM2C, brazoPosC, IMUangC] = funcAngOpti2(Brazo26, Espalda26, IMUs26);
[fkC, fC] = funcFilter(angM2C);

y3 = ANN_SensF_vs_IMU_Fcn(IMUdata26');
accuracy2 = max(abs(fC-y3));
