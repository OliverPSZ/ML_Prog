function [A] = forward_activation(Z, Sigma)
%FORWARD_ACTIVATION Compute the value A of the activation function given Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%
%   outputs:
%       o A (NXM) value of the activation function

switch Sigma
    case "sigmoid"
        A = ones(size(Z,1),size(Z,2))./(1+exp(-Z));     % Get sigmoid activation function 

    case "tanh"
        A = (exp(Z)-exp(-Z))./(exp(Z)+exp(-Z));         % Get tanh activation function 
    
    case "relu"
        A = max(0,Z);                                   % Get ReLu activation function 
    
    case "leakyrelu"
        k = 0.01;                                       % Set k value for leaky ReLu
        A = max(k*Z,Z);                                 % Get LeakyReLu activation function 
    
    case "softmax"
        s = ones(1, ndims(Z)); s(1) = size(Z, 1);       % Get Softmax activation function
        A = (exp(Z-repmat(max(Z), s)))./repmat(sum((exp(Z-repmat(max(Z), s))), 1), s);
end

end