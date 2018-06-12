% 23.04.18
% draw movements from quaternions

load('all_27.mat')
[yaw, pitch, roll] = quat2angle([Q1 Q2 Q3 Q4]);

for i=1:length(yaw)
    funcPlotVector(pitch(i), roll(i), yaw(i))
    % pause(0.1)
end

