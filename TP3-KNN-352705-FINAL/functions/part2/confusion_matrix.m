function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%
%   where positive is encoded by the label 1 and negative is encoded by the label 2.        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pos_est_label = y_est; pos_est_label(pos_est_label~=1)=0;                               % Get the examples with positive estimated labels            
neg_est_label = y_est; neg_est_label(neg_est_label~=2)=0;                               % Get the examples with negative estimated labels 

idx_pos = find(pos_est_label);                                                          % Get indexes of positive estimated values
idx_neg = find(neg_est_label);                                                          % Get indexes of negative estimated values

C = [sum((y_test-pos_est_label)==0), sum((y_test(idx_neg)-neg_est_label(idx_neg))~=0);
    sum((y_test(idx_pos)-pos_est_label(idx_pos))~=0), sum((y_test-neg_est_label)==0)];  % Calculate Confusion Matrix

end

