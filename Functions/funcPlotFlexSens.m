function funcPlotFlexSens(voltageA0, dataFlexSens, T)
% Plot
dataPlot = [voltageA0];
plot(1:T,dataPlot)
title(sprintf('A0: %.2fV Angle: %.2fº   Max: %.2f Avg: %.2f Min: %.2f', (dataFlexSens(4)), (dataFlexSens(5)),(dataFlexSens(1)),(dataFlexSens(2)),(dataFlexSens(3))))
grid on;
axis([0 T dataFlexSens(3) dataFlexSens(1)])
xlabel('Samples') % x-axis label
ylabel('Voltage') % y-axis label
drawnow
end