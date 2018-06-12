% 050218 Function to know the angle from a flex sensor using 20K? R2
% dataFlexSens = [maxVoltage, avgVoltage, minVoltage, voltageA0, angle]
% nCount = sample number
function dataFlexSens = funcFlexSensDynamic(dataFlexSens, nCount)
% Max and Min to Angle
maxVoltage = dataFlexSens(1);
avgVoltage = dataFlexSens(2); % Given by experience with 20K?
minVoltage = dataFlexSens(3);
voltageA0 = dataFlexSens(4);
% calibrate average voltage sensor when starts (after of 3 readings).
% calibration can be made after pressing a button
if nCount == 3 
    avgVoltage = voltageA0;
    maxVoltage = avgVoltage + 0.6;
    minVoltage = avgVoltage - 0.6;
    disp('Calibrated')
end
% Update Max and Min flexSensor values
if voltageA0 > maxVoltage
    maxVoltage = voltageA0;
end
if voltageA0 < minVoltage
    minVoltage = voltageA0;
end
% Calculate angle
if voltageA0 >= avgVoltage
    angle = ((voltageA0 - avgVoltage)/(maxVoltage - avgVoltage)) * 90;
else
    angle = ((voltageA0 - avgVoltage)/(avgVoltage - minVoltage)) * 90;
end
dataFlexSens = [maxVoltage, avgVoltage, minVoltage, voltageA0, angle];
end