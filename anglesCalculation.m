%% 260218 Angles calc
close all
clear
clc
%% Load Data
load('BlueFront.mat');
[r1, r2, r3] = quat2angle([SDBF.Quat1, SDBF.Quat2, SDBF.Quat3, SDBF.Quat4], 'XYZ');
IMU = [r1 r2 r3];
BRAZO = deg2rad(BRAZO);
ESPALDA = deg2rad(ESPALDA);

%% Method 1
A = cat(4,BRAZO(:,1),BRAZO(:,2),BRAZO(:,3));        % Combine the three components in the 4th dimension
B = cat(4,ESPALDA(:,1),ESPALDA(:,2),ESPALDA(:,3));  % Ditto
C = cross(A,B,4);                                   % Take the cross products there.
ang = atan2(sqrt(dot(C,C,4)),dot(A,B,4));           % 

%% Method 2

% Parameters
length1 = 1;
length2 = 1;
posIni = [0 0 0];
% Brazo(:,1) = roll -- Brazo(:,2) = pitch -- Brazo(:,3) = yaw
% Pos V1
xV1 = posIni(1) + cos(BRAZO(:,3)).*cos(BRAZO(:,2))*length1;
yV1 = posIni(2) + sin(BRAZO(:,3)).*cos(BRAZO(:,2))*length1;
zV1 = posIni(3) + sin(BRAZO(:,2)).*length1;
% PosV2
xV2 = posIni(1) + cos(ESPALDA(:,3)).*cos(ESPALDA(:,2))*length1;
yV2 = posIni(2) + sin(ESPALDA(:,3)).*cos(ESPALDA(:,2))*length1;
zV2 = posIni(3) + sin(ESPALDA(:,2)).*length1;
% Angle
angR = [];
for i = 1:length(xV1)
    angR(i,:) = subspace([xV1(i);yV1(i);zV1(i)],[xV2(i);yV2(i);zV2(i)])*2;
end

