function [X, T, day, test, kind] = funcSelectData ()
    X = 0; T = 0; test = 0; kind = 0;
    prompt = ('Tests day [26], [27]: ');
    day = str2double(input(prompt,'s'));
    if day == 26
        prompt = ('Tests [1] Z rotation (Blue), [2] Frontal Elevation (GF), [3] Abduction - adduction (GS): ');
        test = str2double(input(prompt,'s'));
        switch test
            case 1
                dataToLoad = '26B_Match.mat';
            case 2
                dataToLoad = '26GF_Match.mat';
            case 3
                dataToLoad = '26GS_Match.mat';
            otherwise
                fprintf('No data for %d test\n',test)
        end
    elseif day == 27
        prompt = ('Tests [1] Z rotation (Blue), [2] Frontal Elevation (GF), [3] Cross lifting (P), [4] Cross lifting Inverse (PI): ');
        test = str2double(input(prompt,'s'));
        switch test
            case 1
                dataToLoad = '27B_Match.mat';
            case 2
                dataToLoad = '27GF_Match.mat';
            case 3
                dataToLoad = '27P_Match.mat';
            case 4
                dataToLoad = '27PI_Match.mat';
            otherwise
                fprintf('No data for %d test\n',test)
        end
    else
        fprintf('No data for %d day\n',day)
        return
    end
    
    load(dataToLoad)
    
    prompt = ('Kind [1] FlexS vs Shoulder [2] FlexS+IMUq vs Shoulder [3] IMUq vs Shoulder [4] PCA vs Shoulder [5] FlexS vs IMUq [6] PCA vs IMUq: ');
    kind = str2double(input(prompt,'s'));
    switch kind
        case 1
            X = [tableSensorsData.A0 tableSensorsData.A1 tableSensorsData.A2 tableSensorsData.A3 tableSensorsData.A4 ...
            tableSensorsData.A5 tableSensorsData.A6 tableSensorsData.A7 tableSensorsData.A8 tableSensorsData.A9]';
            T = [tableMatched.angBrazoX tableMatched.angBrazoY tableMatched.angBrazoZ]';
        case 2
            X = [tableSensorsData.A0 tableSensorsData.A1 tableSensorsData.A2 tableSensorsData.A3 tableSensorsData.A4 ...
            tableSensorsData.A5 tableSensorsData.A6 tableSensorsData.A7 tableSensorsData.A8 tableSensorsData.A9...
            tableSensorsData.Quat1 tableSensorsData.Quat2 tableSensorsData.Quat3 tableSensorsData.Quat4]';
            T = [tableMatched.angBrazoX tableMatched.angBrazoY tableMatched.angBrazoZ]';
        case 3
            X = [tableSensorsData.Quat1 tableSensorsData.Quat2 tableSensorsData.Quat3 tableSensorsData.Quat4]';
            T = [tableMatched.angBrazoX tableMatched.angBrazoY tableMatched.angBrazoZ]';
        case 4
            X = [tableSensorsData.A0 tableSensorsData.A1 tableSensorsData.A3 tableSensorsData.A4]';
            T = [tableMatched.angBrazoX tableMatched.angBrazoY tableMatched.angBrazoZ]';
        case 5
            X = [tableSensorsData.A0 tableSensorsData.A1 tableSensorsData.A2 tableSensorsData.A3 tableSensorsData.A4 ...
            tableSensorsData.A5 tableSensorsData.A6 tableSensorsData.A7 tableSensorsData.A8 tableSensorsData.A9]';
            T = [tableSensorsData.Quat1 tableSensorsData.Quat2 tableSensorsData.Quat3 tableSensorsData.Quat4]';
        case 6
            X = [tableSensorsData.A0 tableSensorsData.A1 tableSensorsData.A3 tableSensorsData.A4]';
            T = [tableSensorsData.Quat1 tableSensorsData.Quat2 tableSensorsData.Quat3 tableSensorsData.Quat4]';
        otherwise
            disp('other value')
            return
    end
    
    %% plot data
    f = figure;
    p = uipanel('Parent',f,'BorderType','none'); 
    p.Title = (['Data: ' 'Day ' num2str(day) ' test ' num2str(test) ' kind ' num2str(kind)]);
    p.TitlePosition = 'centertop'; 
    p.FontSize = 12;
    p.FontWeight = 'bold';

    subplot(1,2,1,'Parent',p) 
    plot(X')
    title('Input') 

    subplot(1,2,2,'Parent',p) 
    plot(T')
    title('Target')
end