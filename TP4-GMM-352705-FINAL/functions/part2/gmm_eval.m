function [AIC_curve, BIC_curve] =  gmm_eval(X, K_range, repeats, params)
%GMM_EVAL Implementation of the GMM Model Fitting with AIC/BIC metrics.
%
%   input -----------------------------------------------------------------
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o repeats  : (1 X 1), # times to repeat k-means
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%           * max_iter: Max number of iterations for EM algorithm
%
%   output ----------------------------------------------------------------
%       o AIC_curve  : (1 X K), vector of min AIC values for K-range
%       o BIC_curve  : (1 X K), vector of min BIC values for K-range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=K_range
    for j=1:repeats
        params.k = K_range(i);                                                      % Set new value of k
        [Priors, Mu, Sigma, iter] = gmmEM(X, params);                               % Get GMM
        [AIC(j), BIC(j)] =  gmm_metrics(X, Priors, Mu, Sigma, params.cov_type);     % Get metrics
    end
    AIC_curve(:,i) = min(AIC);                                                      % Get minimum AIC value from reapeated iterations
    BIC_curve(:,i) = min(BIC);                                                      % Get minimum BIC value from reapeated iterations
end

end
