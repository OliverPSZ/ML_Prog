function [Y, A, Z] = forward_pass(X, W, W0, Sigmas)
%FORWARD_PASS This function calculate the forward pass of the network with
%   inputs:
%       o X (NxM) The input data
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o Y (PxM) The output of the network, result of the activation
%       function of the last layer
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contain the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer

A=cell(numel(W)+1,1); Z=cell(numel(W),1);               % Initialize cell arrays     

for i=1:numel(W)
    if i==1
        A{i} = X;                                       % Add input data to A0 layer
        Z{i} = W{i}*A{i}+W0{i};                         % Get Z value of A0 layer 
    else
        Z{i} = W{i}*A{i}+W0{i};                         % Get Z value of i-th layer
    end
    A{i+1} = forward_activation(Z{i},Sigmas{i});        % Get results of i-th layer
end
Y = A{numel(A)};                                        % Set Y as the final output of the network

end