%% 21.02.18 Reading Flex sensor data from Arduino UNO.
close all
clear
clc
%% Connection
a1 = arduino('COM6', 'uno');

%% Parameters
T = 100;        % number of samples to view on plot
nCount = 1;     % initial count
nSens = 5;      % number of sensors
voltageInputs = [];

%% Getting data
disp('Reading')
ini = tic;
while nCount <= T
    % Read sensors connected to inputs
    for nSen = 1: nSens
        input = ['A', int2str(nSen - 1)];
        voltageInputs(nSen,nCount) = readVoltage(a1, input); 
    end
    nCount = nCount + 1;
end
tTime = toc(ini);
disp(tTime)
%% disconnect
clear a1
disp('End')
