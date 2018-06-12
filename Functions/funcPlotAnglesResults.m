% function to plot results offline
% data needed:
% initial angles [X,Y,Z]
% angles from results [X,Y,Z]
% length = 10
load('C:\Users\Aldo Contreras\Documents\GitHub\FlexSensor\testsData\test110618N.mat')

L1 = 1; % length

%% add here for loop 
for rawLoop = 1:length(angN)
    clf;
    % from angle and length, get position
    theta1 = angN(rawLoop,1);
    theta2 = angN(rawLoop,2);
    theta3 = angN(rawLoop,3);

    P12 = [0 L1 0]'; % [X Y Z] change arrow direction here

    % from rotation angles get position
    R10 = [1 0 0;
        0 cos(theta1) -sin(theta1);
        0 sin(theta1) cos(theta1)];

    R21 = [cos(theta2) 0 sin(theta2);
        0 1 0;
        -sin(theta2) 0 cos(theta2)];

    R32 = [cos(theta3) -sin(theta3) 0;
        sin(theta3) cos(theta3) 0
        0 0 1];

    R30 = R10 * R21 * R32;
    P30 = R30 * P12;        % Position point

    % plot data
    grid on;
    hold all;
    grid on;
    subplot(2,2,1);
    mArrow3([0 0 0],[P30(1) P30(2) P30(3)], 'color', 'red', 'stemWidth', 0.015);
    axis([-1 1 -1 1 -1 1]);
    view(3);
    
    %2
    subplot(2,2,2);
    hold all;
    grid on;
    plot([0;P30(1)],[0;P30(2)],'r');
    axis([-1 1 -1 1])
    view(0,90);
    
    %3
    subplot(2,2,3);
    hold all;
    grid on;
    plot([0;P30(1)],[0;P30(3)],'r');
    axis([-1 1 -1 1])
    view(0,90);
    
    %4
    subplot(2,2,4);
    hold all;
    grid on;
    plot([0;P30(2)],[0;P30(3)],'r');
    axis([-1 1 -1 1])
    view(0,90);
    
    if rawLoop == 1
       pause(0.05)
    else
        pause(0.05)
    end
end

disp('done!')




