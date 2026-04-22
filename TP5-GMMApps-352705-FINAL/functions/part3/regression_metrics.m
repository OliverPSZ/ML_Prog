function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MSE = 0;                            % Initialize variables
Var = 0;
CD_t = 0;
CD_bl = 0;
CD_br = 0;

for m = 1:size(yest,2)
    MSE = MSE + norm(yest(m) - y(m)).^2;                                                     % Calculate sum of norm between yest and y for all points of dataset
    Var = Var + norm(y(m)-sum(y,2)/size(yest,2)).^2;                                         % Calculate sum of variance from all points of dataset
    CD_t = CD_t + (norm(yest(m)-sum(yest,2)/size(yest,2))*norm(y(m)-sum(y,2)/size(yest,2))); % Calculate sumatorial elements for Coefficient of Determination
    CD_bl = CD_bl + norm(yest(m)-sum(y,2)/size(yest,2)).^2;
    CD_br = CD_br + norm(y(m)-sum(y,2)/size(yest,2)).^2;
end

Var = Var/(size(yest,2)-1);        % Get final variance
MSE = MSE/size(yest,2);            % Get Mean Square Error
NMSE = MSE/Var;                    % Get Normalized Mean Square Error
Rsquared = CD_t^2/(CD_bl*CD_br);   % Get Coefficient of Determination

end


