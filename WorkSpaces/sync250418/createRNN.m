% Script to create RNN with 24.04.18 data
clear
close all
clc

[kindOfData, kindOfTest] = usrDataFunc ();
[WorkSpace] = loadWSFunc(kindOfData);
[input, target] = dataToRNN(WorkSpace, kindOfTest);
[performanceTot] = rnnFunc(input, target);
disp(performanceTot)