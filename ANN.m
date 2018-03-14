clear
close all
clc
%% function to select and plot data
[X, T, day, test, kind] = funcSelectData();

%% ANN 
net = feedforwardnet(30); % hiddenSizes
[net,tr] = train(net,X,T);
y = net(X);
perf = perform(net,y,T);

%% generate ANN Function
funcName = ['ANN' '_' num2str(day) '_' num2str(test) '_' num2str(kind) '_Fnc'];
genFunction(net, funcName);
eval(['y2 = ',funcName,'(X);']);
accuracy = max(abs(y-y2));
disp(max(accuracy))