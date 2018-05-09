function [input, target] = dataToRNN(WorkSpace, option)
% [1]FlexS vs ShoulderAng [2]FlexS+IMUq vs ShoulderAng [3]IMUq vs ShoulderAng 
% [4]PCA vs Shoulder [5] FlexS vs IMUq [6] PCA vs IMUq

    input = [WorkSpace.A0 WorkSpace.A1 WorkSpace.A2 WorkSpace.A3 ...
                WorkSpace.A5 WorkSpace.A5 WorkSpace.A6 WorkSpace.A7 ...
                WorkSpace.A8 WorkSpace.A6 WorkSpace.A10 WorkSpace.A11 ...
                WorkSpace.A12 WorkSpace.A13 WorkSpace.A14];
    switch option
        case 1
            target = [WorkSpace.angBrazoX WorkSpace.angBrazoY WorkSpace.angBrazoZ];
        case 2
            input = [input WorkSpace.Quat1 WorkSpace.Quat2 WorkSpace.Quat3 WorkSpace.Quat4];
            target = [WorkSpace.angBrazoX WorkSpace.angBrazoY WorkSpace.angBrazoZ];
        case 3
            input = [WorkSpace.Quat1 WorkSpace.Quat2 WorkSpace.Quat3 WorkSpace.Quat4];
            target = [WorkSpace.angBrazoX WorkSpace.angBrazoY WorkSpace.angBrazoZ];
        case 4
            input = [WorkSpace.A0 WorkSpace.A1 WorkSpace.A2 WorkSpace.A3]; % TODO: PCA analysis
            target = [WorkSpace.angBrazoX WorkSpace.angBrazoY WorkSpace.angBrazoZ];
        case 5
            target = [input WorkSpace.Quat1 WorkSpace.Quat2 WorkSpace.Quat3 WorkSpace.Quat4];
        case 6
            input = [WorkSpace.A0 WorkSpace.A1 WorkSpace.A2 WorkSpace.A3]; % TODO: PCA analysis
            target = [input WorkSpace.Quat1 WorkSpace.Quat2 WorkSpace.Quat3 WorkSpace.Quat4];
        otherwise
            disp('No option valid')
            target = [];
    end
end