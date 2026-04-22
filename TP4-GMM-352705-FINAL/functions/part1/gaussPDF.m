function prob = gaussPDF(X, Mu, Sigma)
%MY_GAUSSPDF computes the Probability Density Function (PDF) of a
% multivariate Gaussian represented by a mean and covariance matrix.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o Mu    : (N x 1), an Nx1 vector corresponding to the mean of the 
%							Gaussian function
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix 
%						   of the Gaussian function
% Outputs ----------------------------------------------------------------
%       o prob  : (1 x M),  a 1xM vector representing the probabilities for each 
%                           M datapoints given Mu and Sigma    
%%

N = size(X,1);                                                              % Get dataset dimension 
M = size(X,2);                                                              % Get dataset sample size

C = 1/(((2*pi)^(N/2))*(det(Sigma)^(0.5)));                                  % Get values that remain constant while calculating probabilities
Sigma_inv = Sigma^-1;

for i=1:M
    prob(:,i) = C*exp(-0.5*transpose(X(:,i)-Mu)*Sigma_inv*(X(:,i)-Mu));     % Calculate probabilities by iterating in each datapoint
end

end