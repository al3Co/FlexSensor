% Script to test code pieces
clear s
%% Data
load('BlueFront.mat');
[angM1, angM2, IMU] = funcAngOpti2(BRAZO, ESPALDA, SDBF);
ini = 137; fin = 1111;
angM1 = angM1(ini:fin, 1:1);
angM2 = angM2(ini:fin, 1:1);

%% Kalman Filter
s.x = 10;
s.A = 1;
% Define a process noise (stdev) of 2 volts as the car operates:
s.Q = 1^2; % variance, hence stdev^2
% Define the voltimeter to measure the voltage itself:
s.H = 1;
% Define a measurement error (stdev) of 2 volts:
s.R = 5; % variance, hence stdev^2
% Do not define any system input (control) functions:
s.B = 0;
s.u = 0;
% Do not specify an initial state:
s.x = nan;
s.P = nan;
% Generate random voltages and watch the filter operate.
tru=[]; % truth voltage
for t=1:length(angM2)
   tru(end+1) = angM2(t);
   s(end).z = tru(end); % create a measurement
   s(end+1)=kalmanf(s(end)); % perform a Kalman filter iteration
end
figure
hold on
grid on
% plot measurement data:
hz=plot([s(1:end-1).z],'r.');
% plot a-posteriori state estimates:
hk=plot([s(2:end).x],'b-');
%ht=plot(tru,'g-');
%legend([hz hk ht],'observations','Kalman output','true voltage',0)
title('Kalman Angle')
hold off

kalman = [s(2:end).x];