function [Brazo, Espalda, IMUs] = loadDataTest(date)
    switch date
        case '26'
            %% load Data
            load('26B.mat');
            load('26GF.mat');
            load('26GS.mat');
            load('26P.mat');
            load('26PI.mat');
            %% concatenate arrays
            Brazo = cat(1, BrazoBlue, BrazoGF, BrazoGS, BrazoP, BrazoPINV);
            Espalda = cat(1, EspaldaBlue, EspaldaGF, EspaldaGS, EspaldaP, EspaldaPINV);
            IMUs = cat(1, B_IMU_26, GF_IMU_26, GS_IMU_26, P_IMU_26, PI_IMU_26);
        case '27'
            %% load Data
            load('27B.mat');
            load('27GF.mat');
            load('27GS.mat');
            load('27P.mat');
            load('27PI.mat');
            %% concatenate arrays
            Brazo = cat(1, BrazoBlue, BrazoGF, BrazoGS, BrazoP, BrazoPINV);
            Espalda = cat(1, EspaldaBlue, EspaldaGF, EspaldaGS, EspaldaP, EspaldaPINV);
            IMUs = cat(1, B_IMU_27, GF_IMU_27, GS_IMU_27, P_IMU_27, PI_IMU_27);
        otherwise
    end
end