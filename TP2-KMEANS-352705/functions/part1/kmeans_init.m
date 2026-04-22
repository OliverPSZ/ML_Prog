function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch(init)
    case 'sample'
        Mu = datasample(X,k,2);                                             % Get random k samples from dataset X
        
    case 'range'
        min_max = [min(X,[],2),max(X,[],2)];                                % Get min and max values from dataset X
        Mu = min_max(:,1) + (range(min_max')'.*rand(size(min_max,2),k));    % Get random k data points from dataset X 

end