% PCA matrix result from data collected and movements made by 15
% flexsensors. Results shown between Interior and Exterior sensors

clc
clear

movs = {"rotacionzAll", "lateralAll", "frontalAll",...
    "cruzadointAll", "cruzadoextAll"};
movs = string(movs);

column = 1;
coeffInterior = [];
%coeffCovInterior = [];

coeffExterior = [];
%coeffCovExterior = [];

% All the movements in the vector are obtained. 
% A matrix with the coefficients per sensor is created 
% for the interior and exterior data.

for mov = movs
    %disp(mov)
	T = load(mov+".mat");
	T = T.(mov);
    
	interior = [T.A0 T.A1 T.A2 T.A4 T.A7];
    coeff = pca(interior);
	% COEFF = pcacov(interior);
    for row = 1:length(coeff)
        coeffInterior(row, column) = max(coeff(row,:));
        % coeffCovInterior(row, column) = max(COEFF(row,:));    
    end

    exterior = [T.A5 T.A6 T.A7 T.A8 T.A9];
    coeff = pca(exterior);
    % COEFF = pcacov(exterior);
    for row = 1:length(coeff)
        coeffExterior(row, column) = max(coeff(row,:));
        % coeffCovExterior(row, column) = max(coeff(row,:));
    end
    
    column = column + 1;
end

% gets the mean of each sensor to know which fits better the tasks

mean_interior = mean(coeffInterior,2);
[~,In_order] = sort(mean_interior, 'descend')

mean_exterior = mean(coeffExterior,2);
[~,Ex_order] = sort(mean_exterior, 'descend')


%% plotting

fontSize = 14;
numColLeg = 4;

% ax1 = subplot(2,1,1);
figure(1)
bar(coeffInterior,'hist')
title('Internal side','FontSize',fontSize)
x = xlabel('Number of Sensor');
set(x, 'FontSize', fontSize) 
y = ylabel('Coefficient');
set(y, 'FontSize', fontSize) 
ylim([0.4 1])

legend({'Horizontal adduction','Abduction','Flexion',...
    'Closing drill','Opening drill'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')

% ax2 = subplot(2,1,2);
figure(2)
bar(coeffExterior,'hist')
title('External side','FontSize',fontSize)
x = xlabel('Number of Sensor');
set(x, 'FontSize', fontSize) 
y = ylabel('Coefficient');
set(y, 'FontSize', fontSize) 
ylim([0.4 1])

legend({'Horizontal adduction','Abduction','Flexion',...
    'Closing drill','Opening drill'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')
