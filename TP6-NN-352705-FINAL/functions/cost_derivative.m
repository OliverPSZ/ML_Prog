function [dZ] = cost_derivative(Y, Yd, typeCost, typeLayer)
%COST_DERIVATIVE compute the derivative of the cost function w.r.t to the Z
%value of the last layer
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match
%       Yd
%       o Yd (PxM) Ground truth
%       o typeCost (string) type of the cost evaluation function
%       o typeLayer (string) type of the last layer
%   outputs:
%       o dZ (PxM) The derivative dE/dZL

switch typeLayer
    case "sigmoid"
        AZ = Y.*(1-Y);                                              % Get Sigmoid derivative
    case "softmax"
        for i = 1:size(Y,1)
            AZ{i} = -Y(i,:).*Y; AZ{i}(i,:) = AZ{i}(i,:)+Y(i,:);     % Get Softmax derivative
        end
end

dZ = zeros(size(Y,1),size(Y,2));                                    % Initialize derivative cell array

switch typeCost
    case "LogLoss"
        dZ = (-Yd./Y+(1-Yd)./(1-Y)).*AZ;                            % Get LogLoss derivative

    case "CrossEntropy"
        for i=1:size(Y,1)
            dZ = dZ+(-Yd(i,:)./Y(i,:)).*AZ{i};                      % Get Coss Entropy derivative
        end
end

end