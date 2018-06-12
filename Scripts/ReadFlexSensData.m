%% 01.02.18 Reading Flex sensor data from Arduino UNO. Flex Sensor connected to A0
close all
clear
clc
%% Connection
a = arduino('COM6', 'uno');

%% Parameters
T = 100;        % number of samples to view on plot
nCount = 1;
voltageA0 = zeros(T,1);
% dataFlexSens = [maxVoltage, avgVoltage, minVoltage, voltageA0, angle]
dataFlexSens = [2.40, 1.60, 0.80, 0 ,0];

%% Getting data
disp('Plotting ...')
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    if nCount == T
        voltageA0 = voltageA0(2:end, :);
    else
        nCount = nCount + 1;
    end
    % Read data sensor connected to input A0
    voltageA0(nCount,:) = readVoltage(a, 'A0'); 
    % Function to calculate angle
    dataFlexSens(4) = voltageA0(nCount,:);
    dataFlexSens = funcFlexSensDynamic(dataFlexSens, nCount);
    % Function to plot data
    funcPlotFlexSens(voltageA0, dataFlexSens, T)
end

%% disconnect
clear a
disp('End')
