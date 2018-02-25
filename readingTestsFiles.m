% 240218 reading tests files
close all
clear
clc
%% Read and categorice data

JaimeTFM = 'AFCG_Green_Fron_2018-02-23T115847460.xlsx';
Edu = 'AFCG_Green_Side_2018-02-23T121906523.xlsx';
Carlos = 'AFCG_Green_Side_2018-02-23T123450039.xlsx';
OtroLAT  = 'AFCG_Green_Side_2018-02-23T125059133.xlsx';
Roomie1  = 'AFCG_Green_Side_2018-02-23T130301997.xlsx';
Sonia  = 'AFCG_Green_Side_2018-02-23T132000752.xlsx';
Pablo  = 'AFCG_Green_Side_2018-02-23T133414181.xlsx';
Roomie2  = 'AFCG_Green_Side_2018-02-23T135820861.xlsx';
Brenosa = 'AFCG_Green_Side_2018-02-23T151949001.xlsx';
Prima = 'AFCG_Green_Side_2018-02-23T155657865.xlsx';
JaimeB = 'AFCG_Green_Side_2018-02-23T164205229.xlsx';
Doris = 'AFCG_Green_Side_2018-02-23T170422681.xlsx';

T1 = readtable(Carlos);
T2 = readtable(OtroLAT);
T3 = readtable(Roomie1);
T4 = readtable(Sonia);
T5 = readtable(Pablo);
T6 = readtable(Roomie2);
T7 = readtable(Brenosa);
T8 = readtable(JaimeB);
T9 = readtable(Doris);



