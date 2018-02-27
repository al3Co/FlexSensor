%% 270218 ANN IMU + SensFlex VS optiTrack
close all
clear
clc

%% Data
day = '27';
[Brazo, Espalda, IMUs] = loadDataTest(day);

%% angle BTW Shoulder and Back
[angM1, angM2, IMUang] = funcAngOpti2(Brazo, Espalda, IMUs);

%% filtering shoulder data
fk = funcFilter(angM2);

x = 1:length(angM2);
y = fk;
[p,~,mu] = polyfit(x, y, 100);
f = polyval(p,x,[],mu);
%plot([angM2, fk', f'])

%% ANN Feedforward Neural Network

% feed
X = [IMUs.A0 IMUs.A1 IMUs.A2 IMUs.A3 IMUs.A4 IMUs.A5 IMUs.A6 IMUs.A7 IMUs.A8 IMUs.A9 IMUang]'; % INPUTS
T = [f']';
% T = [Brazo Espalda]';

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