% Script to test code pieces
clc
clear all
close
%% Data

day = '27';
[Brazo, Espalda, IMUs] = loadDataTest(day);

%% angle BTW Shoulder and Back
[angM1, angM2, BrazoPos, IMUang] = funcAngOpti2(Brazo, Espalda, IMUs);

%% filtering shoulder data
[fk, f] = funcFilter(angM2);

%plot([angM2, fk', f'])

%% Plot data
flexS = [IMUs.A0 IMUs.A1 IMUs.A2 IMUs.A3 IMUs.A4 IMUs.A5 IMUs.A6 IMUs.A7 IMUs.A8 IMUs.A9];
plot(flexS)