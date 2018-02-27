function PCA_PlotFunc2(data1, data2, data3, data4, data5)

f = figure;
p = uipanel('Parent',f,'BorderType','none'); 
p.Title = 'PCA data Analysis'; 
p.TitlePosition = 'centertop'; 
p.FontSize = 12;
p.FontWeight = 'bold';

[coeff, score, coeff2, score2] = PCA_Function_ToPlot (data1);

subplot(5,2,1,'Parent',p)
hold on
biplot(coeff(:,1:2),'varlabels',{'S_6','S_7','S_8','S_9','S_10'});
title('Test 1 External sensors') 

subplot(5,2,2,'Parent',p) 
biplot(coeff2(:,1:2),'varlabels',{'S_1','S_2','S_3','S_4','S_5'});
title('Test 1 Internal sensors') 

[coeff, score, coeff2, score2] = PCA_Function_ToPlot (data2);

subplot(5,2,3,'Parent',p) 
biplot(coeff(:,1:2),'varlabels',{'S_6','S_7','S_8','S_9','S_10'});
title('Test 2 External sensors') 

subplot(5,2,4,'Parent',p) 
biplot(coeff2(:,1:2),'varlabels',{'S_1','S_2','S_3','S_4','S_5'});
title('Test 2 Internal sensors') 

[coeff, score, coeff2, score2] = PCA_Function_ToPlot (data3);

subplot(5,2,5,'Parent',p) 
biplot(coeff(:,1:2),'varlabels',{'S_6','S_7','S_8','S_9','S_10'});
title('Test 3 External sensors') 

subplot(5,2,6,'Parent',p) 
biplot(coeff2(:,1:2),'varlabels',{'S_1','S_2','S_3','S_4','S_5'});
title('Test 3 Internal sensors') 

[coeff, score, coeff2, score2] = PCA_Function_ToPlot (data4);

subplot(5,2,7,'Parent',p) 
biplot(coeff(:,1:2),'varlabels',{'S_6','S_7','S_8','S_9','S_10'});
title('Test 4 External sensors') 

subplot(5,2,8,'Parent',p) 
biplot(coeff2(:,1:2),'varlabels',{'S_1','S_2','S_3','S_4','S_5'});
title('Test 4 Internal sensors') 

[coeff, score, coeff2, score2] = PCA_Function_ToPlot (data5);

subplot(5,2,9,'Parent',p) 
biplot(coeff(:,1:2),'varlabels',{'S_6','S_7','S_8','S_9','S_10'});
title('Test 5 External sensors') 

subplot(5,2,10,'Parent',p) 
biplot(coeff2(:,1:2),'varlabels',{'S_1','S_2','S_3','S_4','S_5'});
title('Test 5 Internal sensors') 

end