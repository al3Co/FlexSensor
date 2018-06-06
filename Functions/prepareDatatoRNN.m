function [x, xi] = prepareDatatoRNN(input, target)
    % in = input(1,:);
    % tar = target(1,:);
    x = cell(2,0);
    xi = {input';target'};
    
    
    % X = tonndata(input,false,false);
    % T = tonndata(target,false,false);

    % Choose a Training Function
    % For a list of all training functions type: help nntrain
    % 'trainlm' is usually fastest.
    % 'trainbr' takes longer but may be better for challenging problems.
    % 'trainscg' uses less memory. Suitable in low memory situations.
    % trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

    % Create a Nonlinear Autoregressive Network with External Input
    % inputDelays = 1:1;
    % feedbackDelays = 1:1;
    % hiddenLayerSize = 10;
    % net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize,'open',trainFcn);

    % Choose Input and Feedback Pre/Post-Processing Functions
    % Settings for feedback input are automatically applied to feedback output
    % For a list of all processing functions type: help nnprocess
    % Customize input parameters at: net.inputs{i}.processParam
    % Customize output parameters at: net.outputs{i}.processParam
    % net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
    % net.inputs{2}.processFcns = {'removeconstantrows','mapminmax'};

    % Prepare the Data for Training and Simulation
    % The function PREPARETS prepares timeseries data for a particular network,
    % shifting time by the minimum amount to fill input states and layer
    % states. Using PREPARETS allows you to keep your original time series data
    % unchanged, while easily customizing it for networks with differing
    % numbers of delays, with open loop or closed loop feedback modes.
    % [x,xi,ai,t] = preparets(net,X,{},T);
end


