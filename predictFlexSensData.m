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

disp('Plotting ...')
start = tic;
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
set(gcf,'WindowStyle','normal');
while double(get(gcf,'CurrentCharacter'))~=27
    % reading data
    try
        serialData = fscanf(arduino,formatID);
        % fix data with calibration
        for num = 1:nSens
            serialData(num) = serialData(num) - calFixVal(num);
        end
        sensorInputs(:,nCount) = serialData;
        % add 
        nCount = nCount + 1;
    catch
        flushinput(arduino)
        disp('Serial data error')
    end
    % plot data
    % function to plot data
end




%% on work
% disp('Predicting')
% while nCount < nTotal
%     % reading data
%     try
%         serialData = fscanf(arduino,formatID);
%         % fix data with calibration
%         for num = 1:length(calibrationValue)
%             serialData(num) = serialData(num) - calibrationValue(num);
%         end
%         sensorInputs(:,nCount) = serialData;
%         Sample(:,nCount) = nCount;
%         clockT(:,nCount) = clock;
%         nCount = nCount + 1;
%     catch
%         flushinput(arduino)
%         disp('Serial data error')
%         dataFlag = false;
%     end
%     % plot data
%     funcPlotMultFlexSens(sensorInputs, nTotal)
% end

%% closing
fclose(arduino);

