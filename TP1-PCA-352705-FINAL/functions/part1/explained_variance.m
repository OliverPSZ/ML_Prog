function [ExpVar, CumVar, p_opt] = explained_variance(EigenValues, var_threshold)
%EXPLAINED_VARIANCE Function that returns the optimal p given a desired
%   explained variance.
%
%   input -----------------------------------------------------------------
%   
%       o EigenValues     : (N x 1), Diagonal Matrix composed of lambda_i 
%       o var_threshold   : Desired Variance to be explained
%  
%   output ----------------------------------------------------------------
%
%       o ExpVar  : (N x 1) vector of explained variance
%       o CumVar  : (N x 1) vector of cumulative explained variance
%       o p_opt   : optimal principal components given desired Var

EigSum = sum(EigenValues);                  % Get the sum of all EigenValues
ExpVar = EigenValues/EigSum;                % Normalize the EigenValues
CumVar = cumsum(ExpVar);                    % Obtain the vector of the cumulative sum

p_opt = sum(lt(CumVar,var_threshold))+1;    % Estimate the optimal principal components

end

