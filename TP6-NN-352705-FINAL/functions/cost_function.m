function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match Yd
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error

switch type
    case "LogLoss"
        E = (sum(sum(-log(Y(Yd==1))))+sum(sum(-log(1-Y(Yd==0)))))/size(Y,2);    % Get Logarithmic Loss Cost
    case "CrossEntropy"
        for i=1:size(Y,2)
            E_temp(i) = -(Yd(:,i)'*log(Y(:,i)))/size(Y,2);                      % Get Cross Entropy Cost
        end
        E = sum(E_temp);
end

end