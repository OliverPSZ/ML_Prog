function [W, W0] = initialize_weights(LayerSizes, type)
%INITIALIZE_WEIGHTS Initialize the wieghts of the network according to the
%desired type of initialization
%   inputs:
%       o LayerSizes{L+1x1} Cell array containing the sizes of each layers.
%       Also contains the size of A0 input layer
%       o type (string) type of the desired initialization
%       ('random' or 'zeros')
%
%   outputs:
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers

W = cell(numel(LayerSizes)-1,1); W0 = cell(numel(LayerSizes)-1,1);  % Initialize cell arrays

switch type
    case "random"
        for i=1:numel(LayerSizes)-1
            W{i} = randn(LayerSizes{i+1}, LayerSizes{i});           % Get random values for initializing weights
            W0{i} = randn(LayerSizes{i+1}, 1);                      % Get random values for initializing bias
        end

    case "zeros"
        for i=1:numel(LayerSizes)-1
            W{i} = zeros(LayerSizes{i+1}, LayerSizes{i});           % Get zeros for initializing weights
            W0{i} = zeros(LayerSizes{i+1}, 1);                      % Get zeros for initializing bias
        end
        
end

end