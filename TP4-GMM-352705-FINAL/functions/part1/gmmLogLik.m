function [ logl ] = gmmLogLik(X, Priors, Mu, Sigma)
%MY_GMMLOGLIK Compute the likelihood of a set of parameters for a GMM
%given a dataset X
%
%   input------------------------------------------------------------------
%
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Priors : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu     : (N x K), an NxK matrix corresponding to the centroids mu = {mu^1,...mu^K}
%       o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                    Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%
%   output ----------------------------------------------------------------
%
%      o logl       : (1 x 1) , loglikelihood
%%

K = length(Priors);                                                        % Get number of Gaussian components
M = size(X,2);                                                             % Get number of datapoints
logl = 0;                                                                  % Set loglikelihood as zero

for i=1:M
    for j=1:K
        likelihood(j,:) = Priors(j)*gaussPDF(X(:,i),Mu(:,j),Sigma(:,:,j)); % Get likelihood for each datapoint for each set of parameters
    end
    logl = logl+log(sum(likelihood));                                      % Sum log-ed probabilities
end

end

