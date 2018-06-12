%% 22.02.18 Reading Flex sensor and single IMU data
close all
clear
clc
%% COM port closing
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% IMU connection
COMPort = "COM4";
baudrate = 921600;          % rate at which information is transferred
lpSensor = lpms();          % function lpms API sensor given by LPMS
if ( ~lpSensor.connect(COMPort, baudrate) )
    disp('IMU not connected')
    return 
end
lpSensor.setStreamingMode();
disp('IMU ready')

%% arduino Connection
arduino=serial('COM7','BaudRate',9600);
fopen(arduino);
flushinput(arduino)

%% parameters
nTotal = 500;   % samples number
nCount = 1;     % initial sample
data = [];      % variable to save data
nSens = 9;      % number of sensors including zero
Sample = [];    % sample stamp
clockT = [];
dataIMU = [];

% format incoming data
format = '';
for nSen = 0: nSens
    if nSen < nSens
        format = [format , '%f,'];
    else
        format = [format , '%f'];
    end
end

%% reading
disp('reading')
start = tic;
while nCount <= nTotal
    d_IMU = lpSensor.getCurrentSensorData();
    if (~isempty(d_IMU))
        dataIMU(:,nCount) = [d_IMU.timestamp, d_IMU.quat, d_IMU.acc];
        data(:,nCount)= fscanf(arduino,format);
        Sample(:,nCount) = nCount;
        clockT(:,nCount) = clock;
        disp(nCount)
        nCount = nCount + 1;
    end
end
time = toc(start);

%% closing
fclose(arduino);

if (lpSensor.disconnect())
    disp('Sensor disconnected')
end

%% time
disp(time)
disp(nCount/time);

%% Storing data seccion
% formatting
format1 = ''; format2 = '';
format1 = '%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s%12s'; 
format2 = '%12.0f%12d%12d%12.3f%12.2f%12.6f%12.6f%12.6f%12.6f%12.5f%12.5f%12.5f';

str = strings([1,(nSen + 12)]);
str(1) = 'Sample'; str(2) = 'Hour'; str(3) = 'Minute'; str(4) = 'Sec';
str(5) = 'Stamp'; str(6) = 'Quat1'; str(7) = 'Quat2'; str(8) = 'Quat3'; str(9) = 'Quat4';
str(10) = 'AccX'; str(11) = 'AccY'; str(12) = 'AccZ';
for nSen = 0: nSens
    if nSen < nSens
        format1 = [format1 , '%12s'];
        format2 = [format2 , '%12.2f'];
        str(nSen+13) = ['A', int2str(nSen)];
    else
        format1 = [format1 , '%12s\r\n'];
        format2 = [format2 , '%12.2f\r\n'];
        str(nSen+13) = ['A', int2str(nSen)];
    end
end

%% storing Data

% clockT = clockT(4:6,:);
% clockStr = string(clockT);
% time = join(clockStr');
% time = strrep(time,' ','');

clockT2 = clockT(4:6,:);
Hour = clockT2(1,:);
Min = clockT2(2,:);
Sec = clockT2(3,:);

folderName = 'testsData';
[status, msg, msgID] = mkdir(folderName);
dir = [pwd, '\',folderName];
%editField = app.TestEditField.Value;
S = char(datetime('now','Format','yyyy-MM-dd''T''HHmmssSSS'));
fileName = [S,'.txt'];
C = cat(1, Sample, Hour, Min, Sec, dataIMU, data);
fileID = fopen(fullfile(dir,fileName),'wt');
fprintf(fileID, format1, str); % col names
fprintf(fileID, format2, C);
fclose(fileID);

