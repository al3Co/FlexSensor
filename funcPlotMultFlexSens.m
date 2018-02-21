function funcPlotMultFlexSens(voltageA0, T)
% Plot
dataPlot = [voltageA0];
plot(1:T,dataPlot)
%title(sprintf('A0:', voltageA0))
grid on;
xlabel('Samples') % x-axis label
ylabel('Voltage') % y-axis label
drawnow
end