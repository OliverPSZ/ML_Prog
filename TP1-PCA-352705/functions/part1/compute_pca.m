function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix

M = size(X,2);                                         % Get the number of samples of the Dataset

Mu = mean(X.').';                                      % Get the Mean Vector of the given Dataset
X_dm = X-Mu;                                           % Substract the Mean Vector to the Dataset to normalize it

C = (1/(M-1))*(X_dm*X_dm.');                           % Get the Covariance Matrix

[EigVect, evl] = eig(C);                               % Obtain the EigenVectors and EigenValues
EigVal = diag(evl);                                    % Transform EigenValues diagonal matrix to vector

Idx_EVect = [(1:size(EigVect,2));EigVect];             % Add index to EigenVectors
Idx_EVal = [(1:size(EigVal,1)).',EigVal];              % Add index to EigenValues

EigenValues = sort(Idx_EVal(:,2),'descend');           % Sort EigenValues in descending order
[~,idx] = sort(Idx_EVal(:,2),'descend');               % Get sorting index

sorted_EVect = Idx_EVect(:,idx);                       % Sort EigenVectors according to EigenValues 
EigenVectors = sorted_EVect(2:size(sorted_EVect,1),:); % Remove indexes from EigenVectors matrix

end

