%% code to eliminate void values from apriori value
close all
clear
clc
%% 
% get data as table
T = readtable('C:\Users\Aldo Contreras\Documents\ExoFlex\Jaime_TFM\OptiTrack\GREEN-FRONT2.csv');

% data = str2double([T.RigidBody(5:end) T.RigidBody_1(5:end) T.RigidBody_2(5:end) T.RigidBody_7(5:end) T.RigidBody_8(5:end) T.RigidBody_9(5:end)]);
data = str2double([T.RigidBody_3(5:end) T.RigidBody_4(5:end) T.RigidBody_5(5:end) T.RigidBody_10(5:end) T.RigidBody_11(5:end) T.RigidBody_12(5:end) T.Marker_18(5:end) T.Marker_19(5:end) T.Marker_20(5:end)]);

% if nan value on matrix, nan changes for previous immediate value
for col=1:9
    for i = 1:length(data)
      if isnan(data(i, col))
        data(i, col) = data(i-1, col);
      end
    end
end

% plotting "brazo", "espalda" and "referencia" position
plot(data)