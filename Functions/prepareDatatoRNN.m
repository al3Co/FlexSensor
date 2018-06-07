function [x, xi] = prepareDatatoRNN(input, target)
    % in = input(1,:);
    % tar = target(1,:);
    % x = cell(2,0);
    % xi = {input';target'};
        
    X = tonndata(input,false,false);
    T = tonndata(target,false,false);

    trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

    % Create a Nonlinear Autoregressive Network with External Input
    inputDelays = 1:2;
    feedbackDelays = 1:2;
    hiddenLayerSize = 10;
    net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize,'open',trainFcn);

    net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
    net.inputs{2}.processFcns = {'removeconstantrows','mapminmax'};

    [x,xi,ai,t] = preparets(net,X,{},T);
end


