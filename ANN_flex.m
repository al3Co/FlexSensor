% 260218 ANN flex sensors
close all
clear
clc
%% Read and categorice data

load('/Users/aldo/Documents/GitHub/FlexSensor/workSpaceData_UseThis.mat')

A0 = cat(1,T1.A0, T2.A0, T3.A0, T4.A0, T5.A0, T6.A0, T7.A0, T8.A0, T9.A0);
A1 = cat(1,T1.A1, T2.A1, T3.A1, T4.A1, T5.A1, T6.A1, T7.A1, T8.A1, T9.A1);
A2 = cat(1,T1.A2, T2.A2, T3.A2, T4.A2, T5.A2, T6.A2, T7.A2, T8.A2, T9.A2);
A3 = cat(1,T1.A3, T2.A3, T3.A3, T4.A3, T5.A3, T6.A3, T7.A3, T8.A3, T9.A3);
A4 = cat(1,T1.A4, T2.A4, T3.A4, T4.A4, T5.A4, T6.A4, T7.A4, T8.A4, T9.A4);
A5 = cat(1,T1.A5, T2.A5, T3.A5, T4.A5, T5.A5, T6.A5, T7.A5, T8.A5, T9.A5);
A6 = cat(1,T1.A6, T2.A6, T3.A6, T4.A6, T5.A6, T6.A6, T7.A6, T8.A6, T9.A6);
A7 = cat(1,T1.A7, T2.A7, T3.A7, T4.A7, T5.A7, T6.A7, T7.A7, T8.A7, T9.A7);
A8 = cat(1,T1.A8, T2.A8, T3.A8, T4.A8, T5.A8, T6.A8, T7.A8, T8.A8, T9.A8);
A9 = cat(1,T1.A9, T2.A9, T3.A9, T4.A9, T5.A9, T6.A9, T7.A9, T8.A9, T9.A9);

Q1 = cat(1,T1.Quat1, T2.Quat1, T3.Quat1, T4.Quat1, T5.Quat1, T6.Quat1, T7.Quat1, T8.Quat1, T9.Quat1);
Q2 = cat(1,T1.Quat2, T2.Quat2, T3.Quat2, T4.Quat2, T5.Quat2, T6.Quat2, T7.Quat2, T8.Quat2, T9.Quat2);
Q3 = cat(1,T1.Quat3, T2.Quat3, T3.Quat3, T4.Quat3, T5.Quat3, T6.Quat3, T7.Quat3, T8.Quat3, T9.Quat3);
Q4 = cat(1,T1.Quat4, T2.Quat4, T3.Quat4, T4.Quat4, T5.Quat4, T6.Quat4, T7.Quat4, T8.Quat4, T9.Quat4);

H = cat(1,T1.Hour, T2.Hour, T3.Hour, T4.Hour, T5.Hour, T6.Hour, T7.Hour, T8.Hour, T9.Hour);
M = cat(1,T1.Minute, T2.Minute, T3.Minute, T4.Minute, T5.Minute, T6.Minute, T7.Minute, T8.Minute, T9.Minute);
S = cat(1,T1.Sec, T2.Sec, T3.Sec, T4.Sec, T5.Sec, T6.Sec, T7.Sec, T8.Sec, T9.Sec);

[AngYaw, AngPitch, AngRoll] = quat2angle([Q1 Q2 Q3 Q4]);



%% RNA


input = [A0 A1 A2 A3 A4 A5 A6 A7 A8 A9]'; % INPUTS
% target = [Angle from IMUs and Voltage from flexSensor]'
target = [AngPitch AngRoll AngYaw]';
net = feedforwardnet(10);
[net,tr] = train(net,input,target);
view(net)
% performance
y = net(input);
perf = perform(net,y,target);
% testing network
%output = net([]');
% generate Function
genFunction(net,'ANN_ExoData_Fcn');
y2 = ANN_ExoData_Fcn(input);
accuracy2 = max(abs(y-y2));
