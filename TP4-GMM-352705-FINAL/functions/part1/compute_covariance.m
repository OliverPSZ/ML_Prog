function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

N = size(X,1);                                                          % Get dataset dimension 
M = size(X,2);                                                          % Get dataset sample size

switch type
    case 'full'
        Sigma = (1/(M-1))*(X-X_bar)*transpose(X-X_bar);                 % Full covariance matrix calculation

    case 'diag'
        s = (1/(M-1))*(X-X_bar)*transpose(X-X_bar);                     % Full covariance matrix calculation
        Sigma = diag(diag(s));                                          % Disregard off-diagonal elements

    case 'iso'
        s = (1/(N*M))*sumsqr(distance_to_centroids(X, X_bar, 'L2'));    % Get isotropic variance                                  % Get isotropic variance
        Sigma = diag(repelem(s,N));                                     % Replicate the isotropic variance in a diagonal matrix

end
end

