%% 19.03.18 Reading X Flex sensor Y Lilys and Z IMU sensors
close all
clear
clc
%% principal parameters
numIMUS = 2;                    % number of IMUS connected
numLilys = 3;                   % number of Ard connected
nSens = 5;                      % number of flex Sensor connected for each Ard
nCount = 1;                     % number of count on loop
editFieldText = 'tests_25_04';  % file name
gesture = 'combo4';          % kind of gesture to record
flagIMUData = false;            % IMU sync flag

%% COM port cleaning
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% Arduinos
disp('Arduinos ...')
ardPorts = [{'COM10'} {'COM8'} {'COM9'}];
for i=1:numLilys
    arduinos(i,:) = serial(ardPorts(i),'BaudRate',9600);
    fopen(arduinos(i));
    flushinput(arduinos(i));
end

%% IMU SENSORS
disp('IMU sensors ...')
IMUPorts = [{'COM3'} {'COM4'}]; % COM Ports to which IMUs are connected
baudrate = 921600;              % rate at which information is transferred
lpSensor1 = lpms();             % object lpms API sensor 1 given by LPMS
lpSensor2 = lpms();             % object lpms API sensor 2 given by LPMS
% connecting
if ( ~lpSensor1.connect(IMUPorts(1), baudrate) || ~lpSensor2.connect(IMUPorts(2), baudrate) )
    disp('Sensors not connected')
    return 
end
lpSensor1.setStreamingMode();
lpSensor2.setStreamingMode();
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
    dataIMU1 = lpSensor1.getQueueSensorData();        % get queue IMU1 sensor data
    dataIMU2 = lpSensor2.getQueueSensorData();        % get queue IMU2 sensor data
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
        Sample(nCount,:) = nCount;
        clockT(nCount,:) = clock;
        dataIMUs(nCount,:) = [dataIMU1.timestamp dataIMU1.quat dataIMU1.acc ...
                              dataIMU2.timestamp dataIMU2.quat dataIMU2.acc];
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

format1 = '%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s'; 
format2 = '%12.0f%12d%12d%12.3f%12.2f%12.6f%12.6f%12.6f%12.6f%12.5f%12.5f%12.5f%12.2f%12.6f%12.6f%12.6f%12.6f%12.5f%12.5f%12.5f';
numData = 16+1+3+(nSens*numLilys); % 16 IMUs + 1 Sample + 3 Clock + N SensFlex
str = strings([1,(numData)]);
str(1) = 'Sample'; str(2) = 'Hour'; str(3) = 'Minute'; str(4) = 'Sec';
str(5) = 'Stamp'; str(6) = 'Quat1'; str(7) = 'Quat2'; str(8) = 'Quat3'; str(9) = 'Quat4';
str(10) = 'AccX'; str(11) = 'AccY'; str(12) = 'AccZ';
str(13) = 'Stamp2'; str(14) = 'Quat2_1'; str(15) = 'Quat2_2'; str(16) = 'Quat2_3'; str(17) = 'Quat2_4';
str(18) = 'Acc2_X'; str(19) = 'Acc2_Y'; str(20) = 'Acc2_Z';
for nSen = 1: (nSens*numLilys)
    if nSen < (nSens*numLilys)
        format1 = [format1 , '%12s'];
        format2 = [format2 , '%12.2f'];
        str(nSen+(numData-(nSens*numLilys))) = ['A', int2str(nSen-1)];
    else
        format1 = [format1 , '%12s\r\n'];
        format2 = [format2 , '%12.2f\r\n'];
        str(nSen+(numData-(nSens*numLilys))) = ['A', int2str(nSen-1)];
    end
end

% directory
folderName = 'testsData';
[status, msg, msgID] = mkdir(folderName);
dir = [pwd, '\',folderName];
S = char(datetime('now','Format','yyyy-MM-dd''T''HHmmssSSS'));
fileName = [editFieldText, '_', gesture, '_', S,'.txt'];

% writing file
fileID = fopen(fullfile(dir,fileName),'wt');
fprintf(fileID, format1, str); % col names
fprintf(fileID, format2, Data');
fclose(fileID);

% storing Workspace
fileName = [editFieldText, '_', gesture, '_', S,'.mat'];
save(fileName,'Data')

%% disconnecting
disp('Disconnecting')
clear arduinos
if (lpSensor1.disconnect() && lpSensor2.disconnect())
    disp('Sensors disconnected')
end
disp('Done!')