function [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu)
%MY_METRICS Computes the metrics (RSS, AIC, BIC) for clustering evaluation
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^D 
%
%   output ----------------------------------------------------------------
%
%       o RSS      : (1 x 1), Residual Sum of Squares
%       o AIC      : (1 x 1), Akaike Information Criterion
%       o BIC      : (1 x 1), Bayesian Information Criteria
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = size(X,1);
K = size(Mu,2);
M = size(X,2);
RSS = 0;
for i=1:K  
    for j=1:M 
        if(labels(j)==i)
            RSS = RSS+sumsqr(abs(X(:,j)-Mu(:,i)));      % Sum of distances between each datapoint from its centroid for all clusters
        end
    end
end

AIC = RSS + 2*(K*N);                                    % Get the AIC Metric          
BIC = RSS + log(M)*(K*N);                               % Get the BIC Metric

end