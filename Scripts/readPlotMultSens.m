%% 21.02.18 Reading Flex sensor data from Arduino UNO.
close all
clear all
clc
%% Connection
a1 = arduino('COM9', 'Mega2560');

%% Parameters
T = 100;        % number of samples to view on plot
nCount = 1;     % initial count
nSens = 6;      % number of sensors
for nSen = 1: nSens
    voltageInputs(nSen,:) = zeros(T,1);
end

%% Getting data
disp('Plotting ...')
ini = tic;
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    % keep plot new data at the end
    if nCount == T
        voltageInputs(:,1) = [];    % delete first column
    else
        nCount = nCount + 1;
    end
    % reading data
    for nSen = 1: nSens
        input = ['A', int2str(nSen - 1)];
        voltageInputs(nSen,nCount) = readVoltage(a1, input); 
    end
    % plot data
    funcPlotMultFlexSens(voltageInputs, T)
end
tTime = toc(ini);
disp(tTime)
%% disconnect
clear a1
disp('End')
