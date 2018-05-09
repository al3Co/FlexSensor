function [WorkSpace] = loadWSFunc(kindOfData)
% load data with analysis characteristics
% [0]All, [1]COMBO, [2]CRUZEXT, [3]CRUZINT, [4]ELEFRONT, [5]LATERAL, [6]ROTZ
    switch kindOfData
        case 0
            name = 'All';
            WorkSpace = extractData(name);
        case 1
            name = 'combo';
            WorkSpace = extractData(name);
        case 2
            name = "cruzadoext";
            WorkSpace = extractData(name);
        case 3
            name = 'cruzadoint';
            WorkSpace = extractData(name);
        case 4
            name = 'elevFrontal';
            WorkSpace = extractData(name);
        case 5
            name = 'lateral';
            WorkSpace = extractData(name);
        case 6
            name = 'rotacionz';
            WorkSpace = extractData(name);
        otherwise
            WorkSpace = [];
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