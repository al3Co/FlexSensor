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
arduino = serial('/dev/tty.usbserial-FTG4DJZ7','BaudRate',9600);
nSens = 6;                      % number of sensors
nCalSamples = 100;              % samples number
nCount = 1;                     % initial sample
calV = zeros(nSens,nCalSamples);% calibration matrix
kindOfPrediction = true;              % kind of prediction true -> ann, false -> rnn
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
    plot(1:nCalSamples,sensorInputs)
    grid on;
    drawnow
end
time = toc(start);
fprintf('Time:  %f\n',time);
fprintf('Speed: %f samples/second\n',(nCount/time));

calFixVal = calV(:,1);

%% predicting

sensorInputs = []; 
nCount = 0;
x = cell(2,0);
targetVec = [0.609465,-0.304610,0.496887,-0.537465; 
          0.609778,-0.304149,0.497088,-0.537185];            % initial angles for first two values

disp('Predicting')
start = tic;
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    % reading data
    lastwarn('') % Clear last warning message
    try
        serialData = fscanf(arduino,formatID);
        flagData = true;
        [warnMsg, warnId] = lastwarn;
        nCount = nCount + 1;
    catch
        flagData = false;
        flushinput(arduino)
        disp('Serial data error')
    end
    
    if flagData && isempty(warnMsg)
        % fix data with calibration
        for num = 1:nSens
            serialData(num) = serialData(num) - calFixVal(num); 
        end
        sensorInputs(nCount,:) = serialData;

        % predict angles
        if nCount > 2
            [quaternions] = anglePred_Func(sensorInputs, targetVec, kindOfPrediction);
            prediction(nCount,:) = quaternions;
            disp(quaternions)
            %  plot data
            [yaw, pitch, roll] = quat2angle(quaternions);
            funcPlotVectorV2(pitch, roll, yaw)
        end
    end
end

%% closing
time = toc(start);
fprintf('Time:  %f\n',time);
fprintf('Speed: %f samples/second\n',(nCount/time));
fclose(arduino);
close all

