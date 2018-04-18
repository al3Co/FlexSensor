clc
clear
close all
% load and save all tests from day 27
load('C:\Users\Aldo Contreras\Documents\GitHub\FlexSensor\WorkSpaces\270218\27B_Match.mat')
B27 = [tableMatched tableSensorsData];
load('C:\Users\Aldo Contreras\Documents\GitHub\FlexSensor\WorkSpaces\270218\27GF_Match.mat')
GF27 = [tableMatched tableSensorsData];
load('C:\Users\Aldo Contreras\Documents\GitHub\FlexSensor\WorkSpaces\270218\27P_Match.mat')
P27 = [tableMatched tableSensorsData];
load('C:\Users\Aldo Contreras\Documents\GitHub\FlexSensor\WorkSpaces\270218\27PI_Match.mat')
PI27 = [tableMatched tableSensorsData];
clear tableMatched tableOpti tableSensorsData

% creating x and y variables to be analyzed on Neural Network
X = [B27.A0 B27.A1 B27.A2 B27.A3 B27.A4 B27.A5 B27.A6 B27.A7 B27.A8 B27.A9;
    GF27.A0 GF27.A1 GF27.A2 GF27.A3 GF27.A4 GF27.A5 GF27.A6 GF27.A7 GF27.A8 GF27.A9;
    P27.A0 P27.A1 P27.A2 P27.A3 P27.A4 P27.A5 P27.A6 P27.A7 P27.A8 P27.A9;
    PI27.A0 PI27.A1 PI27.A2 PI27.A3 PI27.A4 PI27.A5 PI27.A6 PI27.A7 PI27.A8 PI27.A9];

y = [B27.Quat1 B27.Quat2 B27.Quat3 B27.Quat4;
    GF27.Quat1 GF27.Quat2 GF27.Quat3 GF27.Quat4;
    P27.Quat1 P27.Quat2 P27.Quat3 P27.Quat4;
    PI27.Quat1 PI27.Quat2 PI27.Quat3 PI27.Quat4];
clear B27 GF27 P27 PI27