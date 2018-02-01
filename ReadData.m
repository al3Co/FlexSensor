%% 01.02.18 Reading Flex sensor data from Arduino UNO. Sensor connected to A0
close all
clear
clc

%% Connection
a = arduino('COM5', 'uno');
writeDigitalPin(a, 'D13', 1);
%%Parameters
T = 100;        % number of samples to view on plot
nCount = 1;
voltageS1 = zeros(T,1);
voltageS2 = zeros(T,1);
%FEK = zeros(T,1);
%sample = [];

%% Getting data
disp('Plotting ...')
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    clf;
    if nCount == T
        voltageS1 = voltageS1(2:end, :);
        voltageS2 = voltageS2(2:end, :);
        %FEK = FEK(2:end, :);
    else
        nCount = nCount + 1;
    end
    voltageS1(nCount,:) = readVoltage(a, 'A0'); % Sensor 1 connected to input A0. Already converted to 0-5V
    voltageS2(nCount,:) = readVoltage(a, 'A1'); % Sensor 2 connected to input A1. Already converted to 0-5V
    %FEK(nCount,:) = kalman_voltage(voltageS1);
    
    dataPlot = [voltageS1, voltageS2];
    plot(1:T,dataPlot)
    title(sprintf('Voltage S1 = %fV S2 = %fV', (voltageS1(nCount)), (voltageS2(nCount))))
    grid on;
    axis([0 T 0 5])
    xlabel('Samples') % x-axis label
    ylabel('Voltage') % y-axis label
    %legend('UP','DWN')
    drawnow
end
writeDigitalPin(a, 'D13', 0);
%% Saving on file
% fileID = fopen('muscle_firstTest.txt','w');
% fprintf(fileID,'%10s %10s\r\n','Stamp','Data');
% fprintf(fileID,'%10.2f %10.4f\r\n',nCount, voltage(nCount));
% fclose(fileID);

%% Plotting all saved data
% TODO

disp('End')
