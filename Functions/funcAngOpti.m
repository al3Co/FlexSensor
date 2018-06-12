function [angR, angD, IMU] = funcAngOpti(test)
switch test
    case 'BF'
        load('BlueFront.mat');
        [r1, r2, r3] = quat2angle([SDBF.Quat1, SDBF.Quat2, SDBF.Quat3, SDBF.Quat4], 'XYZ');
        IMU = [r1 r2 r3];
        BRAZO = deg2rad(BRAZO);
        ESPALDA = deg2rad(ESPALDA);

        A = cat(4,BRAZO(:,1),BRAZO(:,2),BRAZO(:,3));        % Combine the three components in the 4th dimension
        B = cat(4,ESPALDA(:,1),ESPALDA(:,2),ESPALDA(:,3));  % Ditto
        C = cross(A,B,4);                                   % Take the cross products there.
        angR = atan2(sqrt(dot(C,C,4)),dot(A,B,4));          %
        angD = rad2deg(angR);    
    case 'GS'
        load('GreenSideways.mat');
        [r1, r2, r3] = quat2angle([SDGS.Quat1, SDGS.Quat2, SDGS.Quat3, SDGS.Quat4], 'XYZ');
        IMU = [r1 r2 r3];
        BRAZO = deg2rad(BRAZO);
        ESPALDA = deg2rad(ESPALDA);

        A = cat(4,BRAZO(:,1),BRAZO(:,2),BRAZO(:,3));        % Combine the three components in the 4th dimension
        B = cat(4,ESPALDA(:,1),ESPALDA(:,2),ESPALDA(:,3));  % Ditto
        C = cross(A,B,4);                                   % Take the cross products there.
        angR = atan2(sqrt(dot(C,C,4)),dot(A,B,4));          %
        angD = rad2deg(angR);
    case 'PF'
        load('PurpleFront.mat');
        [r1, r2, r3] = quat2angle([SDPF.Quat1, SDPF.Quat2, SDPF.Quat3, SDPF.Quat4], 'XYZ');
        IMU = [r1 r2 r3];
        BRAZO = deg2rad(BRAZO);
        ESPALDA = deg2rad(ESPALDA);

        A = cat(4,BRAZO(:,1),BRAZO(:,2),BRAZO(:,3));        % Combine the three components in the 4th dimension
        B = cat(4,ESPALDA(:,1),ESPALDA(:,2),ESPALDA(:,3));  % Ditto
        C = cross(A,B,4);                                   % Take the cross products there.
        angR = atan2(sqrt(dot(C,C,4)),dot(A,B,4));          %
        angD = rad2deg(angR);
    case 'PI'
        load('PurpleInverse.mat');
        [r1, r2, r3] = quat2angle([SDPI.Quat1, SDPI.Quat2, SDPI.Quat3, SDPI.Quat4], 'XYZ');
        IMU = [r1 r2 r3];
        BRAZO = deg2rad(BRAZO);
        ESPALDA = deg2rad(ESPALDA);

        A = cat(4,BRAZO(:,1),BRAZO(:,2),BRAZO(:,3));        % Combine the three components in the 4th dimension
        B = cat(4,ESPALDA(:,1),ESPALDA(:,2),ESPALDA(:,3));  % Ditto
        C = cross(A,B,4);                                   % Take the cross products there.
        angR = atan2(sqrt(dot(C,C,4)),dot(A,B,4));          %
        angD = rad2deg(angR);

    otherwise
        warning('Unexpected value. BF GS PF or PI.')
end