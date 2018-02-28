% Script to test code pieces
clc
clear all
close
%% Data

day = '27';
[Brazo, Espalda, IMUs] = loadDataTest(day);

%% angle BTW Shoulder and Back
[angM1, angM2, BrazoPos, IMUang, IMUQ] = funcAngOpti2(Brazo, Espalda, IMUs);

%% filtering shoulder data
[fk, f] = funcFilter(angM2);

%plot([angM2, fk', f'])
Brazo = deg2rad(Brazo);
%% Plot data
flexS = [IMUs.A1 IMUs.A3 IMUs.A4];
plot(Brazo);
legend('Ax','Ay','Az')
xlabel('Sample'), %ylabel('Sensor Voltage')
title('Shoulder Data given by OptiTrack');

%plot(IMUQ)
%plot(Brazo)
