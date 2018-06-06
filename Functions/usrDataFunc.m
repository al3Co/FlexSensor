function [kindOfData, kindOfTest] = usrDataFunc ()
% ask for kind of analysis and data
    while true
        prompt = ('Test: [0]All, [1]COMBO, [2]CRUZEXT, [3]CRUZINT, [4]ELEFRONT, [5]LATERAL, [6]ROTZ, [7]Fixed: ');
        kindOfData = input(prompt);
        if kindOfData >= 0 && kindOfData <= 7
            break
        end
    end
    while true
        prompt = ('Select\n [1] FlexS vs ShoulderAng\n [2] FlexS+IMUq vs ShoulderAng\n [3] IMUq vs ShoulderAng\n [4] PCA vs Shoulder\n [5] FlexS vs IMUq\n [6] PCA vs IMUq\n Kind: ');
        kindOfTest = input(prompt);
        if kindOfTest >= 1 && kindOfTest <= 6
            break
        end
    end
    clc
end