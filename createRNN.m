% Script to create RNN with 24.04.18 data
clear
close all
clc
%% data
[kindOfData, kindOfTest] = usrDataFunc ();
[WorkSpace] = loadWSFunc(kindOfData);
[input, target] = dataToRNN(WorkSpace, kindOfTest);
plot(input)
hold on
plot(target)
%% RNN
[performanceTot] = rnnFunc(input, target);
disp(performanceTot)