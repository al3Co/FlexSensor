%% ANN comparison 
close all
clear
clc

load('workSpace_ANN.mat')


%X = [A0 A1 A3]'; % INPUTS
T = [AngPitch AngRoll AngYaw]';


%% Feedforward Neural Network

net = feedforwardnet(10); % hiddenSizes
[net,tr] = train(net,X,T);
%view(net)
% performance
y = net(X);
perf = perform(net,y,T);
% testing network
%output = net([1.41 2.07 1.31]');
% generate Function
% genFunction(net,'ANN_feedforwardNet_Fcn');
% y2 = ANN_feedforwardNet_Fcn(X);
% accuracy = max(abs(y-y2));

%% output data
final2000 = [0.289585386538777;0.587714316856017;3.08832882878214];
disp(final2000);
% disp(ftdnn_out);
% disp(output);