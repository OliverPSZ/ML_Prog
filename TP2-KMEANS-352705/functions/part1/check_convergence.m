function [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, tol_iter, MaxIter, MaxTolIter, tolerance)
%CHECK_CONVERGENCE Check if the kmeans main loop has converged to a
%solution
%
%   input -----------------------------------------------------------------
%   
%       o Mu : Current value of the centroids
%       o Mu_previous : Previous value of the centroids
%       o iter : Current number of iterations
%       0 tol_iter : Number of iterations since Mu = Mu_previous
%       o MaxIter : Maximum number of iterations
%       o MaxTolIter : Maximum number of iterations for stabilization (Mu =
%       Mu_previous)
%       o tolerance : tolerance for considering Mu = Mu_previous
%
%   output ----------------------------------------------------------------
%
%       o has_converged : true if one of the convergence situation is met
%       o tol_iter : previous tol_iter incremented if stabilization but no
%       convergence, 0 otherwise
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if iter>MaxIter | tol_iter>MaxTolIter    % Verify if the condition for convergence happened
    has_converged = true;                % Set convergence flag to "true"
else
    has_converged = false;               % Maintain the flag in a "false" value if conditions are haven't happened
end
if (Mu-Mu_previous)<tolerance            % Verify if the Mu is approx equal to Mu(t-1) within the tolerance
    tol_iter = tol_iter+1;               % Increment value of tolerance iterations
else
    tol_iter = 0;                        % Maintain the value of tolerance iterations as zero
end
