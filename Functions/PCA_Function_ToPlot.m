function [coeff, score, coeff2, score2] = PCA_Function_ToPlot (data)
Xint = [data.A0 data.A1 data.A2 data.A3 data.A4];
Xext= [data.A5 data.A6 data.A7 data.A8 data.A9];
[coeff,score,latent] = pca(Xext -mean(Xext));
[coeff2,score2,latent2] = pca(Xint - mean(Xint));
end