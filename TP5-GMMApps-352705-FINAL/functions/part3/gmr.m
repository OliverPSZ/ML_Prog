function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_est = zeros(length(out),size(X,2));                                % Initialize output arrays
var_est = zeros(length(out),length(out),size(X,2));

for k = 1:length(Priors)
    Pk_x(k,:) = Priors(k).*gaussPDF(X,Mu(in,k),Sigma(in,in,k));      % Get multiplication of priors and probability density function
end

for k = 1:length(Priors)
    B_k(k,:) = Priors(k).*gaussPDF(X, Mu(in,k), Sigma(in,in,k))./sum(Pk_x,1);               % Get Beta of k-th GMM component
    Mu_k(:,:,k) = Mu(out,k)+ Sigma(out,in,k)*inv(Sigma(in,in,k))*(X-Mu(in,k));              % Get Mu of k-th GMM component
    y_est = y_est + B_k(k,:).*Mu_k(:,:,k);                                                  % Get sum of y_est of k-th GMM component
    Sigma_k(:,:,k) = Sigma(out,out,k)-Sigma(out,in,k)*inv(Sigma(in,in,k))*Sigma(in,out,k);  % Get Sigma of k-th GMM component
end

for m = 1:size(X,2)
    for k = 1:length(Priors)
        var_est(:,:,m) = var_est(:,:,m) + B_k(k,m).*(Mu_k(:,m,k).^2+Sigma_k(:,:,k));
    end
    var_est(:,:,m) = var_est(:,:,m)-y_est(:,m).^2;                                          % Get expected covariance matrices
end 

end

