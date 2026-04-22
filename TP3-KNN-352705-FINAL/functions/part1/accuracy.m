function [acc] =  accuracy(y_test, y_est)
%My_accuracy Computes the accuracy of a given classification estimate.
%   input -----------------------------------------------------------------
%   
%       o y_test  : (1 x M_test),  true labels from testing set
%       o y_est   : (1 x M_test),  estimated labes from testing set
%
%   output ----------------------------------------------------------------
%
%       o acc     : classifier accuracy
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delta = y_test-y_est;                                          % Compare values from test and estimated labels via substraction
delta(delta~=0)=inf; delta(delta==0)=1; delta(delta==inf)=0;   % Get a binary vector of the correctly classified data

acc = sum(delta)/length(y_test);                               % Get accuracy by dividing the sum of correctly classified data by the amount of test points

end