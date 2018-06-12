%% 270218 get angles and plot data
close all
clear
clc
%% load Data
load('BlueFront.mat');

%% get angles
[angM1, angM2, IMU] = funcAngOpti2(BRAZO, ESPALDA, SDBF);

%% cut wrong values
ini = 137; fin = 1111;
BRAZO = BRAZO(ini:fin, 1:3);
ESPALDA = ESPALDA(ini:fin, 1:3);
IMU = IMU(ini:fin, 1:3);
angM1 = angM1(ini:fin, 1:1);
angM2 = angM2(ini:fin, 1:1);
SDBF = SDBF(ini:fin, 1:21);

%% plot data
% plot(BRAZO)
% plot(ESPALDA)
% plot(IMU)

f = figure;
p = uipanel('Parent',f,'BorderType','none'); 
p.Title = 'My Super Title'; 
p.TitlePosition = 'centertop'; 
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,2,1,'Parent',p) 
plot(angM1)
title('Brazo') 

subplot(1,2,2,'Parent',p) 
plot(angM2)
title('Espalda')


