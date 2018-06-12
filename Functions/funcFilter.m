function [fk, f] = funcFilter(ang)
%% KF
clear s
s.x = 10;
s.A = 1;
% Define a process noise (stdev) of 2 volts as the car operates:
s.Q = 1^2; % variance, hence stdev^2
% Define the voltimeter to measure the voltage itself:
s.H = 1;
% Define a measurement error (stdev) of 2 volts:
s.R = 5; % variance, hence stdev^2
% Do not define any system input (control) functions:
s.B = 0;
s.u = 0;
% Do not specify an initial state:
s.x = nan;
s.P = nan;
% Generate random voltages and watch the filter operate.
tru=[]; % truth voltage
for t=1:length(ang)
   tru(end+1) = ang(t);
   s(end).z = tru(end); % create a measurement
   s(end+1)=kalmanf(s(end)); % perform a Kalman filter iteration
end
fk = [s(2:end).x];

%% Poly
x = 1:length(ang);
y = fk;
[p,~,mu] = polyfit(x, y, 100);
f = polyval(p,x,[],mu);

end