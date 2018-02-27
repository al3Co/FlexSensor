function PCA_PlotFunc(data)

Xint = [data.A0 data.A1 data.A2 data.A3 data.A4];
Xext= [data.A5 data.A6 data.A7 data.A8 data.A9];
[coeff,score,latent] = pca(zscore(Xext));
[coeff2,score2,latent2] = pca(zscore(Xint));
figure('Name', 'External sensors');
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_6','v_7','v_8','v_9','v10'});
figure('Name', 'Internal sensors');
biplot(coeff2(:,1:2),'scores',score2(:,1:2),'varlabels',{'v_1','v_2','v_3','v_4','v5'});

end