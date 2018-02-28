% 260218 ANN IMU VS SHOULDER
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
X = [IMUang]'; % INPUTS
%T = [Brazo Espalda]';
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