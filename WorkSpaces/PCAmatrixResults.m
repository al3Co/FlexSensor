% PCA matrix result from data collected and movements made by 15
% flexsensors. Results shown between Interior and Exterior sensors

clc
clear

movs = {"rotacionzAll", "lateralAll", "frontalAll",...
    "cruzadointAll", "cruzadoextAll"};
movs = string(movs);

column = 1;
coeffInterior = [];
coeffCovInterior = [];

coeffExterior = [];
coeffCovExterior = [];

for mov = movs
    disp(mov)
	T = load(mov+".mat");
	T = T.(mov);
    
	interior = [T.A0 T.A1 T.A2 T.A3 T.A4 T.A5 T.A6];
    coeff = pca(interior);
	% COEFF = pcacov(interior);
    for row = 1:length(coeff)
        coeffInterior(row, column) = max(coeff(row,:));
        % coeffCovInterior(row, column) = max(COEFF(row,:));    
    end

    exterior = [T.A7 T.A8 T.A9 T.A10 T.A11 T.A12 T.A13 T.A14];
    coeff = pca(exterior);
    % COEFF = pcacov(exterior);
    for row = 1:length(coeff)
        coeffExterior(row, column) = max(coeff(row,:));
        % coeffCovExterior(row, column) = max(coeff(row,:));
    end
    
    column = column + 1;
end

%% plotting

fontSize = 12;
numColLeg = 4;

% ax1 = subplot(2,1,1);
figure(1)
bar(coeffInterior,'hist')
title('Internal side','FontSize',fontSize)
xlabel('Number of Sensor')
ylabel('Coefficient')

legend({'Horizontal displacement','Abduction','Flexion',...
    'Ascending-closing screw','Ascending-opening screw'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')

% ax2 = subplot(2,1,2);
figure(2)
bar(coeffExterior,'hist')
title('External side','FontSize',fontSize)
xlabel('Number of Sensor')
ylabel('Coefficient')

legend({'Horizontal displacement','Abduction','Flexion',...
    'Ascending-closing screw','Ascending-opening screw'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')
