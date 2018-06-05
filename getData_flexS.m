%% 21.02.18 Reading Flex sensor data from Serial Port
%% initialization
close all
clear all
clc
% clearing serial port
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% parameters
arduino = serial('COM9','BaudRate',9600);
nSens = 6;      % number of sensors including zero
nTotal = 100;   % samples number
nCount = 1;     % initial sample
data = [];      % variable to save data
Sample = [];    % sample stamp
dataFlag = true;
clockT = [];
fopen(arduino);
flushinput(arduino)

%% format serial incoming data
formatID = '';
for nSen = 1: nSens
    if nSen < nSens
        formatID = [formatID , '%f,'];
    else
        formatID = [formatID , '%f'];
    end
    voltageInputs(nSen,:) = zeros(nTotal,1);
end

%% read & plot
disp('Plotting ...')
start = tic;
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    % keep plot new data at the end
    if nCount == nTotal
        voltageInputs(:,1) = [];    % delete first column
        clockT(:,1) = [];
    elseif dataFlag
        nCount = nCount + 1;
    end
    % reading data
    try
        serialData = fscanf(arduino,formatID);
        voltageInputs(:,nCount) = serialData;
        Sample(:,nCount) = nCount;
        clockT(:,nCount) = clock;
        dataFlag = true;
    catch
        flushinput(arduino)
        disp('Serial data error')
        dataFlag = false;
    end
    % plot data
    funcPlotMultFlexSens(voltageInputs, nTotal)
end
time = toc(start);

%% closing
fclose(arduino);
fprintf('Time:  %f\n',time);
fprintf('Speed: %f samples per second\n',(nCount/time));
