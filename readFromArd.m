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