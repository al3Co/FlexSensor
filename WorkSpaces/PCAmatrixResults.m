% PCA matrix result from data collected and movements made by 15
% flexsensors. Results shown between Interior and Exterior sensors

clc
clear

movs = {"rotacionzAll", "lateralAll", "frontalAll",...
    "cruzadointAll", "cruzadoextAll"};
movs = string(movs);

column = 1;
coeffInterior = [];
explInterior = [];
contributionsInt = [];

coeffExterior = [];
explExterior = [];
contributionsExt = [];

% All the movements in the vector are obtained. 
% A matrix with the coefficients per sensor is created 
% for the interior and exterior data.

for mov = movs
    %disp(mov)
	T = load(mov+".mat");
	T = T.(mov);
    
	interior = [T.A0 T.A1 T.A2 T.A4 T.A7];
    [coeff,~,~,~,explained,~] = pca(interior);
    explInterior(:,column) = explained;
    coeffPos = abs(coeff);

    for row = 1:length(coeff)
        coeffInterior(row, column) = max(coeff(row,:));
        
        sume = sum(coeffPos(:,row));
        coeffPos(:,row) = coeffPos(:,row)/sume;
        
        contributionsInt(row,column) = explained(1) * coeffPos(1,row) + ...
            explained(2) * coeffPos(2,row) + explained(3) * coeffPos(3,row);
    end
    
    exterior = [T.A5 T.A6 T.A7 T.A8 T.A9];
    [coeff,~,~,~,explained,~] = pca(exterior);
    explExterior(:,column) = explained;
    coeffPos = abs(coeff);

    for row = 1:length(coeff)
        coeffExterior(row, column) = max(coeff(row,:));
        
        sume = sum(coeffPos(:,row));
        coeffPos(:,row) = coeffPos(:,row)/sume;
        contributionsExt(row,column) = explained(1) * coeffPos(1,row) + ...
            explained(2) * coeffPos(2,row) + explained(3) * coeffPos(3,row);
    end
    
    column = column + 1;
end

% gets the mean of each sensor to know which fits better the tasks

mean_interior = mean(coeffInterior,2);
[~,In_order] = sort(mean_interior, 'descend');

mean_exterior = mean(coeffExterior,2);
[~,Ex_order] = sort(mean_exterior, 'descend');


for i = 1: length(contributionsExt)
   for j = 1: length(contributionsExt)
       Int(i,j) = contributionsInt(i,j)/coeffInterior(i,j);
       Ext(i,j) = contributionsExt(i,j)/coeffExterior(i,j);
   end
end


for i = 1: length(contributionsExt)
    sume = sum(contributionsInt(:,1));
    contributionsIntRatio(:,i) = contributionsInt(:,i)/sume;
    
    sume = sum(contributionsExt(:,1));
    contributionsExtRatio(:,i) = contributionsExt(:,i)/sume;
end


for i = 1: length(contributionsExt)
    sumContSensInt(i) = sum(contributionsInt(:,i));
    sumContSensExt(i) = sum(contributionsExt(:,i));
end

% 
sumContSensInt = sumContSensInt/(max(sumContSensInt));
sumContSensExt = sumContSensExt/(max(sumContSensExt));
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
xticklabels({'6','7','8','9','10'})
y = ylabel('Coefficient');
set(y, 'FontSize', fontSize) 
ylim([0.4 1])

legend({'Horizontal adduction','Abduction','Flexion',...
    'Closing drill','Opening drill'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')

figure(3)
bar(contributionsInt,'hist')
title('Internal side','FontSize',fontSize)
x = xlabel('Number of Sensor');
set(x, 'FontSize', fontSize) 
y = ylabel('Sensivity to motions %');
set(y, 'FontSize', fontSize) 

legend({'Horizontal adduction','Abduction','Flexion',...
    'Closing drill','Opening drill'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')

figure(4)
bar(contributionsExt,'hist')
title('External side','FontSize',fontSize)
x = xlabel('Number of Sensor');
set(x, 'FontSize', fontSize)
xticklabels({'6','7','8','9','10'})
y = ylabel('Sensivity to motions %');
set(y, 'FontSize', fontSize)

legend({'Horizontal adduction','Abduction','Flexion',...
    'Closing drill','Opening drill'},...
    'Location','southoutside',...
    'NumColumns',numColLeg, 'FontSize',fontSize)
legend('boxoff')

