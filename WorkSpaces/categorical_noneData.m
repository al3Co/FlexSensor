% this code gets the data needed for pca or ann analisys

clc
clear

load('allFixed_none.mat', 'allFixed_none');

Data = allFixed_none;
sensors = [Data.A0 Data.A1 Data.A2 Data.A3 Data.A4 Data.A5 Data.A6 Data.A7 Data.A8 Data.A9 Data.A10 Data.A11 Data.A12 Data.A13 Data.A14];
clear Data
type = categorical(allFixed_none.type);
[typeNumeric, order] = grp2idx(type);
