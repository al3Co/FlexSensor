%Sensor time correction
function [SensorTime] = STCorrection(SensorFile)

x = readtable(SensorFile);

SensorTime = seconds(hours(x.Hour) + minutes(x.Minute) + seconds(x.Sec));

end