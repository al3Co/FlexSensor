%% preparing Data for NN
clc
clear
% getting data
load('allData.mat', 'allData');
D = allData;

% sensors
sensorsAll = [D.A0 D.A1 D.A2 D.A3 D.A4 D.A5 D.A6 D.A7 D.A8 D.A9];
sensorsInt = [D.A0 D.A1 D.A2 D.A3 D.A4];
sensorsExt = [D.A5 D.A6 D.A7 D.A8 D.A9];
sensPCA = [D.A7 D.A2 D.A1 D.A0];

% quaternions
quatIMU = [D.Quat2_1 D.Quat2_2 D.Quat2_3 D.Quat2_4];
quatOpti = angle2quat(D.angBrazoX, D.angBrazoY, D.angBrazoZ);
clear D

% categorical type, dummy var
type = categorical(allData.type);
[typeNumeric, order] = grp2idx(type);

D = dummyvar(typeNumeric);

dumm = zeros(length(typeNumeric),3);
for row = 1:length(typeNumeric)
    switch typeNumeric(row,:)
        case 1
            dumm(row,:) = [0,0,0];
        case 2
            dumm(row,:) = [0,0,1];
        case 3
            dumm(row,:) = [0,1,0];
        case 4
            dumm(row,:) = [0,1,1];
        case 5
            dumm(row,:) = [1,0,0];
        case 6
            dumm(row,:) = [1,0,1];
    end
end

% mixing data
sensorAll_type = [sensorsAll D];
sensorI_type = [sensorsInt D];
sensorE_type = [sensorsExt D];
sensPCA_type = [sensPCA D];

sensPCA_IMU = [sensPCA_type quatIMU];
sensPCA_Opti = [sensPCA_type quatOpti];
sensI_IMU = [sensorsInt quatIMU];
sensE_IMU = [sensorsExt quatIMU];
