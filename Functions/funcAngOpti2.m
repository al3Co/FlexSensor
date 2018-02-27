function [angM1, angM2, IMU] = funcAngOpti2(BRAZO, ESPALDA, FLEX_DATA)
%% IMU to angle
[r1, r2, r3] = quat2angle([FLEX_DATA.Quat1, FLEX_DATA.Quat2, FLEX_DATA.Quat3, FLEX_DATA.Quat4], 'XYZ');
IMU = [r1 r2 r3];

%% preparing data
BRAZO = deg2rad(BRAZO);
ESPALDA = deg2rad(ESPALDA);

%% Method 1
A = cat(4,BRAZO(:,1),BRAZO(:,2),BRAZO(:,3));        % Combine the three components in the 4th dimension
B = cat(4,ESPALDA(:,1),ESPALDA(:,2),ESPALDA(:,3));  % Ditto
C = cross(A,B,4);                                   % Take the cross products there.
angM1 = atan2(sqrt(dot(C,C,4)),dot(A,B,4));          % calculate angle

%% Metod 2
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
xV2 = posIni(1) + cos(ESPALDA(:,3)).*cos(ESPALDA(:,2))*length2;
yV2 = posIni(2) + sin(ESPALDA(:,3)).*cos(ESPALDA(:,2))*length2;
zV2 = posIni(3) + sin(ESPALDA(:,2)).*length2;
% Angle
angM2 = [];
for i = 1:length(xV1)
    angM2(i,:) = subspace([xV1(i);yV1(i);zV1(i)],[xV2(i);yV2(i);zV2(i)])*2;
end

end