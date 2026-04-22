function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function

switch Sigma
    case "sigmoid"
        dZ = (ones(size(Z,1),size(Z,2))./(1+exp(-Z))).*(1-(ones(size(Z,1),size(Z,2))./(1+exp(-Z))));  % Get sigmoid backward activation function 

    case "tanh"
        dZ = 1-((exp(Z)-exp(-Z))./(exp(Z)+exp(-Z))).^2;                                               % Get tanh backward activation function 
    
    case "relu"
        dZ = ones(size(Z,1), size(Z,2)); [~,idx]=find(Z<0); dZ(idx) = 0;                              % Get ReLu backward activation function 
        
    case "leakyrelu"
        k = 0.01;                                                                                     % Set k value for leaky ReLu
        dZ = ones(size(Z,1), size(Z,2)); [~,idx]=find(Z<0); dZ(idx) = k;                              % Get LeakyReLu activation function 
        
end

end