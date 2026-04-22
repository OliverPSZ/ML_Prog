function [ TP_rate, FP_rate ] = knn_ROC( X_train, y_train, X_test, y_test,  params )
%KNN_ROC Implementation of ROC curve for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_test   : (1 x M_test), a vector with labels y \in {1,2} corresponding to X_test.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------

%       o TP_rate  : (1 x K), True Positive Rate computed for each value of k.
%       o FP_rate  : (1 x K), False Positive Rate computed for each value of k.
%        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:length(params.k_range)                      % Loop to evaluate different values of k
    
    params.k = params.k_range(i);                   % Set the new value of k that will be evaluated to new struct      
    y_est =  knn(X_train,  y_train, X_test, params);     % Calculate y_est for the specific value of k
    C = confusion_matrix(y_test, y_est);            % Calculate the confusion matrix

    TP_rate(i) = C(1,1)/(C(1,1)+C(1,2));            % Calculate the TPR
    FP_rate(i) = C(2,1)/(C(2,1)+C(2,2));            % Calculate the FPR

end
end