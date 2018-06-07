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

%% initial parameters
arduino = serial('COM9','BaudRate',9600);
nSens = 6;                      % number of sensors
nCalSamples = 500;              % samples number
nCount = 1;                     % initial sample
calV = zeros(nSens,nCalSamples);% calibration matrix
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
end
sensorInputs = zeros(nSens,nCalSamples);
%% read & plot
disp('calibrating ...')
start = tic;
while nCount <= nCalSamples
    % reading data
    try
        serialData = fscanf(arduino,formatID);
        sensorInputs(:,nCount) = serialData;
        nCount = nCount + 1;
    catch
        flushinput(arduino)
        disp('Serial data error')
    end
    % calibration
    for n = 1:nSens
        calV(n,:) = ones(1,nCalSamples)*(min(sensorInputs(n,:)));
    end
    % plot data
    plot(1:nCalSamples,[sensorInputs; calV])
    grid on;
    drawnow
end
time = toc(start);
fprintf('Time:  %f\n',time);
fprintf('Speed: %f samples/second\n',(nCount/time));
close all
calFixVal = calV(:,1);

%% predicting
% reset parameteres
sensorInputs = []; 
nCount = 1;
x = cell(2,0);
target = [];            % initial angles for first two values

disp('Predicting')
start = tic;
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    % reading data
    try
        serialData = fscanf(arduino,formatID);
        for num = 1:nSens
            serialData(num) = serialData(num) - calFixVal(num); % fix data with calibration
        end
        sensorInputs(:,nCount) = serialData;
        
        % predict angles
        if nCount > 2
            input = [];         % vector with the last 2 inputs, get from sensor Inputs the last 2 samples
            [x, xi] = prepareDatatoRNN(input, target);
            [Y,Xf,Af] = rnn_created_Fnc(x,xi);
            target = Xf{2,1};
            [yaw, pitch, roll] = quat2angle(target);
            funcPlotVectorV2(pitch, roll, yaw)

            % input = [past, new];
            % target = [past, new];
        end 
        nCount = nCount + 1;
    catch
        flushinput(arduino)
        disp('Serial data error')
    end
    % plot data
    % funcPlotVectorV2(pitch, roll, yaw)
end

%% closing
time = toc(start);
fprintf('Time:  %f\n',time);
fprintf('Speed: %f samples/second\n',(nCount/time));
close all
fclose(arduino);

