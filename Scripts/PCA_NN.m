load('allMovements.mat')
allM = allMovements;
clear allMovements;

flexS = [allM.A0 allM.A1 allM.A2 allM.A3 allM.A4 allM.A5 allM.A6 allM.A7...
        allM.A8 allM.A9 allM.A10 allM.A11 allM.A12 allM.A13 allM.A14];
names = {'A0' 'A1' 'A2' 'A3' 'A4' 'A5' 'A6' 'A7' 'A8' 'A9' 'A10' 'A11'...
        'A12' 'A13' 'A14'};
[coeff,score,latent,tsquared,explained,mu] = pca(flexS,'VariableWeights','variance');

Xcentered = score*coeff';

h = biplot(coeff(:,1:3),'scores',score(:,1:3),'varlabels',names);