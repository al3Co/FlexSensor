function [x, xi] = prepareDatatoRNN(input, target)
%     input_vrg = [0.2000 0.2100 0.6300 0.6500 0.2600 0.0400;
%                  0.2000 0.2100 0.6300 0.6500 0.2600 0.0400];
%     target_vrg = [0.609465,-0.304610,0.496887,-0.537465;
%                   0.609778,-0.304149,0.497088,-0.537185]
    % in = input(1,:);
    % tar = target(1,:);
    x = cell(2,0);
    % xi = {input';target'};
    xi = [tonndata(input,false,false); tonndata(target,false,false)];
    
    
%     X = tonndata(input,false,false);
%     T = tonndata(target,false,false);
% 
%     trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.
% 
%     % Create a Nonlinear Autoregressive Network with External Input
%     inputDelays = 1:2;
%     feedbackDelays = 1:2;
%     hiddenLayerSize = 10;
%     net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize,'open',trainFcn);
% 
%     net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
%     net.inputs{2}.processFcns = {'removeconstantrows','mapminmax'};
% 
%     [x,xi,ai,t] = preparets(net,X,{},T);
end


