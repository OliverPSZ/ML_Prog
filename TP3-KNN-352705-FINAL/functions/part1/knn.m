function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:size(X_test,2)                                                % Loop for iterating along all points in the test set
                                                
    for j=1:size(X_train,2)                                           % Loop for iterating along all points in the training set
        d(j) = compute_distance(X_test(:,i),X_train(:,j),params);     % Get and store distances between the i-th test point and the j-th train point
    end

    [~,idx] = sort(d,'ascend');                                       % Get sorting index of distances in ascending order
    y_knn = y_train(idx);                                             % Order the train labels
    c = unique(y_knn);                                                % Get the unique labels
    [~,y_argmax] = max(histc(y_knn(1:params.k), c));                  % Get the index of the mayority vote from y_knn
    y_est(:,i) = c(y_argmax);                                         % Get the value of the estimated label
    
end

end