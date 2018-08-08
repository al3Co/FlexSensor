%% 19.03.18 Reading X Flex sensor Y Lilys and Z IMU sensors data and save it on file
% ### Known Issues:
% - Serial Interrupt routine blocks main processing thread when transferring at data rate > 100Hz 
% - 16bit data parsing is not yet implemented
% - For more than one sensor, change the Transmission rate in such a way that does not exceed 100Hz (Use LpCVP conv. tool and LpmsControl software)
% 
% ### LpVCPConversionTool:
% https://bitbucket.org/lpresearch/openmat/downloads/LpVCPConversionTool-1.0.0-Setup.exe
% 
% ### Drivers:
% https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers

close all
clear
clc
%% principal parameters
numLilys = 1;                   % number of Ard connected
nSens = 6;                      % number of flex Sensor connected for each Ard
nCount = 1;                     % count on loop
kindOfTest = 'testsDate';       % file name
gesture = 'gesture';            % kind of gesture to record
flagIMUData = false;            % IMU sync flag

%% COM port cleaning
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% Arduinos
disp('Arduinos ...')
%ardPorts = [{'COM10'} {'COM8'} {'COM9'}];
ardPorts = [{'COM9'}];
for i=1:numLilys
    arduinos(i,:) = serial(ardPorts(i),'BaudRate',9600);
    fopen(arduinos(i));
    flushinput(arduinos(i));
end

%% IMU SENSORS
disp('IMU sensors ...')
IMUPorts = [{'COM4'} {'COM6'}]; % COM Ports to which IMUs are connected
[~,numIMUS] = size(IMUPorts);      % num of IMUS connected
baudrate = 921600;              % rate at which information is transferred

% create nIMUs instances
for imu = 1:numIMUS
    lpSensor(imu) = lpms();
end

% connecting
for imu = 1:numIMUS
    if ( ~lpSensor(imu).connect(IMUPorts(imu), baudrate) )
        return 
    end
end

% Set streaming mode
for imu = 1:numIMUS
    lpSensor(imu).setStreamingMode();
end
disp('All set up, starting reading ...')

%% format serial incoming data
formatID = '';
for nSen = 1: nSens
    if nSen < nSens
        formatID = [formatID , '%f,'];
    else
        formatID = [formatID , '%f'];
    end
end

%% reading method
disp('PRESS A KEY TO STOP READING, DO NOT CLOSE THE WINDOW UNTIL THE END')
global KEY_IS_PRESSED
KEY_IS_PRESSED = 0;
gcf;
set(gcf, 'KeyPressFcn', @myKeyPressFcn);
now = tic;
while ~KEY_IS_PRESSED
    for imu = 1:numIMUS
        dataIMU1 = lpSensor(imu).getQueueSensorData();        % get queue IMU1 sensor data
        dataIMU2 = lpSensor(imu).getQueueSensorData();        % get queue IMU2 sensor data
    end
    % Sync Method
    if (~isempty(dataIMU1)) && (~isempty(dataIMU2))
        flagIMUData = true;
    elseif (~isempty(dataIMU1)) && (isempty(dataIMU2))
        while (isempty(dataIMU2))
            dataIMU2 = lpSensor2.getQueueSensorData();
        end
        flagIMUData = true;
    elseif (~isempty(dataIMU2)) && (isempty(dataIMU1))
        while (isempty(dataIMU1))
            dataIMU1 = lpSensor1.getQueueSensorData();
        end
        flagIMUData = true;
    elseif (isempty(dataIMU2)) && (isempty(dataIMU1))
        flagIMUData = false;
    end
    % Synchronized data
    if flagIMUData
        % reading IMUs data
        Sample(nCount,:) = nCount;
        clockT(nCount,:) = clock;
        dataIMUs(nCount,:) = [dataIMU1.timestamp dataIMU1.quat dataIMU1.acc dataIMU1.gyr...
                              dataIMU2.timestamp dataIMU2.quat dataIMU2.acc dataIMU2.gyr];
                          
        % reading Serial data
        try
            startingData = 1;
            for i=1:numLilys
                dataArd(nCount,startingData:1:(nSens*i)) = fscanf(arduinos(i),formatID);
                startingData = startingData + nSens;
                drawnow
            end
            nCount = nCount +1;
        catch
            disp('Serial Arduino Data error')
        end
        flagIMUData = false;
    end
    drawnow
end
time = toc(now);
speed = nCount/time;
fprintf('Count: %d time: %f avg speed: %f\n',nCount, time, speed);

%% preparing vectors
Hour = clockT(:,4);
Min = clockT(:,5);
Sec = clockT(:,6);
Data = [Sample Hour Min Sec dataIMUs dataArd];

%% storing
% formatting
disp('Storing Data ...')

formatTitles = '%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s'; 
formatData = '%12d%12d%12d%12.3f%12.2f%12.6f%12.6f%12.6f%12.6f%12.5f%12.5f%12.5f%12.5f%12.5f%12.5f%12.2f%12.6f%12.6f%12.6f%12.6f%12.5f%12.5f%12.5f%12.5f%12.5f%12.5f';
numData = 22+1+3+(nSens*numLilys); % 22 IMUs + 1 Sample + 3 Clock + N SensFlex
str = strings([1,(numData)]);
str(1) = 'Sample'; str(2) = 'Hour'; str(3) = 'Minute'; str(4) = 'Sec';
str(5) = 'Stamp1'; str(6) = 'Quat1_1'; str(7) = 'Quat1_2'; str(8) = 'Quat1_3'; str(9) = 'Quat1_4';
str(10) = 'Acc1X'; str(11) = 'Acc1Y'; str(12) = 'Acc1Z';
str(13) = 'gyr1X'; str(14) = 'gyr1Y'; str(15) = 'gyr1Z';
str(16) = 'Stamp2'; str(17) = 'Quat2_1'; str(18) = 'Quat2_2'; str(19) = 'Quat2_3'; str(20) = 'Quat2_4';
str(21) = 'Acc2X'; str(22) = 'Acc2Y'; str(23) = 'Acc2Z';
str(24) = 'gyr2X'; str(25) = 'gyr2Y'; str(26) = 'gyr2Z';
for nSen = 1: (nSens*numLilys)
    if nSen < (nSens*numLilys)
        formatTitles = [formatTitles , '%12s'];
        formatData = [formatData , '%12.2f'];
        str(nSen+(numData-(nSens*numLilys))) = ['A', int2str(nSen-1)];
    else
        formatTitles = [formatTitles , '%12s\r\n'];
        formatData = [formatData , '%12.2f\r\n'];
        str(nSen+(numData-(nSens*numLilys))) = ['A', int2str(nSen-1)];
    end
end

% directory
folderName = 'testsData';
[status, msg, msgID] = mkdir(folderName);
dir = [pwd, '\',folderName];
dateS = char(datetime('now','Format','yyyy-MM-dd''T''HHmmssSSS'));
fileName = [kindOfTest, '_', gesture, '_', dateS,'.txt'];

% writing file
fileID = fopen(fullfile(dir,fileName),'wt');
fprintf(fileID, formatTitles, str); % col names
fprintf(fileID, formatData, Data');
fclose(fileID);

% storing Workspace
fileName = [kindOfTest, '_', gesture, '_', dateS,'.mat'];
save(fileName,'Data')

%% disconnecting
disp('Disconnecting')
clear arduinos
% disconnecting
for imu = 1:numIMUS
    if (lpSensor(imu).disconnect())
        disp('sensor disconnected')
        %fprinf
    end
end
disp('Done!')