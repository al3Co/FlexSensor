%% angle prediction
function [quaternions] = anglePred_Func (sensorInputs, targetVec, prediction)
    % sensorInputs, sensor's raw data
    % targetVec, target's raw data
    % prediction true -> ann, false -> rnn
    if prediction
        % ann
        input = sensorInputs(end:end,1:end);
        [Y,~,~] = ann_created_Fnc(input);
        quaternions = Y;
    else
        % rnn
        % get from sensorInputs the last 2 samples
        input = sensorInputs(end-1:end,1:end);
        target = targetVec(end-1:end,1:end);
        % prepare data to rnn
        xi = [tonndata(input,false,false); tonndata(target,false,false)];
        % rnn function
        [~,Xf,~] = rnn_created_Fnc(x,xi);
        targetVec(nCount,:) = Xf{2,2};
        quaternions = targetVec(end,1:4); 
    end
end
