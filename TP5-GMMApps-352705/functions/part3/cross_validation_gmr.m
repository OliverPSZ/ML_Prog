function [metrics] = cross_validation_gmr( X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:length(k_range)                                                                           % Iterate for each k in k_range
    params.k=k_range(k);                                                                          % Set k-th k value to params structure

    for i=1:F_fold                                                                                % Iterate number of folds of cross-validation to compute
        [X_train, y_train, X_test, y_test] = split_regression_data(X, y, valid_ratio);            % Split regression data according to valid ratio 
        [Priors, Mu, Sigma, ~] = gmmEM([X_train;y_train], params);                                % Get GMM from data
        [yest, ~]=gmr(Priors, Mu, Sigma, X_test, 1:size(X,1), size(X,1)+1:(size(X,1)+size(y,1))); % Calculate GMR
        [MSE(i), NMSE(i), R2(i)]=regression_metrics(yest, y_test);                                % Calculate Regression Metrics
        [AIC(i), BIC(i)]=gmm_metrics([X_train;y_train], Priors, Mu, Sigma, params.cov_type);      % Calculate GMM Metrics
    end

    metrics.mean_MSE(k)=mean(MSE);       % Store means of metrics in metrics structure
    metrics.mean_NMSE(k)=mean(NMSE);
    metrics.mean_R2(k)=mean(R2);
    metrics.mean_AIC(k)=mean(AIC);
    metrics.mean_BIC(k)=mean(BIC);

    metrics.std_MSE(k)=std(MSE);         % Store standard deviations of metrics in metrics structure
    metrics.std_NMSE(k)=std(NMSE);
    metrics.std_R2(k)=std(R2);
    metrics.std_AIC(k)=std(AIC);
    metrics.std_BIC(k)=std(BIC);
end

end

