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

kindOfMov = 'lateral'; % change here the kind of movement

%% COM port cleaning
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% getting ready
disp('Connecting IMU sensors ...')
baudrate = 921600;              % rate at which information is transferred
nCount = 1;
flagIMUData = false;            % IMU sync flag

% create nIMUs instances
lpSensor1 = lpms();
lpSensor2 = lpms();

% connecting
if (~lpSensor1.connect('COM9', baudrate) || ~lpSensor2.connect('COM10', baudrate))
    disp('Sensor not connected')
    return 
end

% Set streaming mode
lpSensor1.setStreamingMode();
lpSensor2.setStreamingMode();
disp('All set up')

%% reading method
disp('PRESS A KEY TO STOP READING, DO NOT CLOSE THE WINDOW UNTIL THE END')
global KEY_IS_PRESSED
KEY_IS_PRESSED = 0;
gcf;
set(gcf, 'KeyPressFcn', @myKeyPressFcn);
while ~KEY_IS_PRESSED
    dataIMU1 = lpSensor1.getQueueSensorData(); % getCurrentSensorData();
    dataIMU2 = lpSensor2.getQueueSensorData(); % getCurrentSensorData();
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
        Sample(nCount,:)	= nCount;
        clockT(nCount,:)	= clock;
        StampA(nCount,:)    = dataIMU1.timestamp;
        QuatA(nCount,:)     = dataIMU1.quat;
        AccA(nCount,:)      = dataIMU1.acc;
        GyrA(nCount,:)      = dataIMU1.gyr;
        StampB(nCount,:)    = dataIMU2.timestamp;
        QuatB(nCount,:)     = dataIMU2.quat;
        AccB(nCount,:)      = dataIMU2.acc;
        GyrB(nCount,:)      = dataIMU2.gyr;
        nCount = nCount +1;
    end
    drawnow
end

%%
disp('Disconnecting')
if (lpSensor1.disconnect() && lpSensor1.disconnect())
    disp('Sensor disconnected')
end
%% storing
time = [clockT(:,4) clockT(:,5) clockT(:,6)];
Data = table(Sample, time, StampA, QuatA, AccA, GyrA, StampB, QuatB, AccB, GyrB);

dateS = char(datetime('now','Format','yyyy-MM-dd''T''HHmmssSSS'));
name = [kindOfMov,dateS,'.mat'];
save(name, 'Data');
disp('Done! Please, close the window Figure')