function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

N = size(X,1);                                                             % Get dimension size
M = size(X,2);                                                             % Get number of datapoints

Priors = (1/M)*sum(Pk_x.');                                                % Get updated mixing weights

for i=1:params.k
    Mu(:,i) = sum((repmat(Pk_x(i,:),2,1).*X),2)./sum(Pk_x(i,:),2);         % Get updated centroids
end

switch params.cov_type
    case 'full'                                                            % Get updated full covariance matrix
        for i=1:params.k
            Sigma(:,:,i) = ((repmat(Pk_x(i,:),2,1).*(X-Mu(:,i)))*((X-Mu(:,i)).'))./sum(Pk_x(i,:),2);
        end
        
    case 'diag'                                                            % Get updated diag covariance matrix
        for i=1:params.k
            Sigma(:,:,i) = diag(diag(((repmat(Pk_x(i,:),2,1).*(X-Mu(:,i)))*((X-Mu(:,i)).'))./sum(Pk_x(i,:),2)));
        end
        
    case 'iso'                                                             % Get updated iso covariance matrix
        for i=1:params.k
            s(:,:,i) = sum(Pk_x(i,:).*(distance_to_centroids(X, Mu(:,i), 'L2')).^2,2)./(N*sum(Pk_x(i,:),2));
            Sigma(:,:,i) = diag(repelem(s(:,:,i),N));
        end
        
end

