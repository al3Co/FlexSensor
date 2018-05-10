function [WorkSpace] = loadWSFunc(kindOfData)
% load data with analysis characteristics
% [0]All, [1]COMBO, [2]CRUZEXT, [3]CRUZINT, [4]ELEFRONT, [5]LATERAL, [6]ROTZ
    switch kindOfData
        case 1
            load 'comboAll.mat' comboAll;
            WorkSpace = comboAll;
        case 2
            load 'cruzadoextAll.mat' cruzadoextAll;
            WorkSpace = cruzadoextAll;
        case 3
            load 'cruzadointAll.mat' cruzadointAll;
            WorkSpace = cruzadointAll;
        case 4
            load 'frontalAll.mat' frontalAll;
            WorkSpace = frontalAll;
        case 5
            load 'lateralAll.mat' lateralAll;
            WorkSpace = lateralAll;
        case 6
            load 'rotacionzAll.mat' rotacionzAll;
            WorkSpace = rotacionzAll;
        case 0
            load 'allData.mat' allData;
            WorkSpace = allData;
        otherwise
            name = 'All';
            WorkSpace = extractData(name);
    end 
end

function WorkSpace = extractData(name)
    load(strcat(name,'1.mat'));
    WorkSpace = allDataTable;
    load(strcat(name,'2.mat'));
    WorkSpace = [WorkSpace; allDataTable];
    load(strcat(name,'3.mat'));
    WorkSpace = [WorkSpace; allDataTable];
    load(strcat(name,'4.mat'));
    WorkSpace = [WorkSpace; allDataTable];
    load(strcat(name,'5.mat'));
    WorkSpace = [WorkSpace; allDataTable];
end