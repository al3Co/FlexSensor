%% preparing Data for NN
clc
clear
% getting data
load('allData.mat', 'allData');
D = allData;

% sensors
% sensorsAll = [D.A0 D.A1 D.A2 D.A3 D.A4 D.A5 D.A6 D.A7 D.A8 D.A9];
% sensorsInt = [D.A0 D.A1 D.A2 D.A3 D.A4];
% sensorsExt = [D.A5 D.A6 D.A7 D.A8 D.A9];
PCA_A = [D.A1 D.A3 D.A4];
PCA_B = [D.A7 D.A9];

% quaternions
IMU = [D.Quat2_1 D.Quat2_2 D.Quat2_3 D.Quat2_4];
Opti = angle2quat(D.angBrazoX, D.angBrazoY, D.angBrazoZ);
clear D

% categorical type, dummy var
type = categorical(allData.type);
[typeNumeric, ~] = grp2idx(type);
clear allData
gesture = dummyvar(typeNumeric);

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
clear row

% mixing data

PCA_A_Gesture = [PCA_A gesture];
PCA_B_Gesture = [PCA_B gesture];

PCA_A_Gesture_IMU = [PCA_A_Gesture IMU];
PCA_B_Gesture_IMU = [PCA_B_Gesture IMU];

