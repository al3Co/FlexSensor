%% 21.02.18 Reading Flex sensor data from Arduino UNO
close all
clear
clc
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
%% parameters
arduino=serial('COM7','BaudRate',9600);
fopen(arduino);
flushinput(arduino)
nTotal = 100;   % samples number
nCount = 1;     % initial sample
data = [];      % variable to save data
nSens = 9;      % number of sensors including zero
Sample = [];    % sample stamp
clockT = [];

%% format from data to recive
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
     data(:,nCount)= fscanf(arduino,format);
     Sample(:,nCount) = nCount;
     clockT(:,nCount) = clock;
     nCount = nCount + 1;
end
time = toc(start);

%% closing
fclose(arduino);
disp(time)
disp(nCount/time);

%% formatting
format1 = ''; format2 = '';
format1 = '%12s%12s%12s%12s'; format2 = '%12.0f%12d%12d%12.4f';

str = strings([1,(nSen + 4)]);
str(1) = 'Sample'; str(2) = 'Hour'; str(3) = 'Minute'; str(4) = 'Sec';

for nSen = 0: nSens
    if nSen < nSens
        format1 = [format1 , '%12s'];
        format2 = [format2 , '%12.2f'];
        str(nSen+5) = ['A', int2str(nSen)];
    else
        format1 = [format1 , '%12s\r\n'];
        format2 = [format2 , '%12.2f\r\n'];
        str(nSen+5) = ['A', int2str(nSen)];
    end
end
disp(format2)

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
C = cat(1, Sample, Hour, Min, Sec, data);
fileID = fopen(fullfile(dir,fileName),'wt');
fprintf(fileID, format1, str); % col names
fprintf(fileID, format2, C);
fclose(fileID);