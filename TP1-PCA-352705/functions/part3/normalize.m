function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization

switch normalization
    
    case "none"
        
        param1 = 0;                                 % Set param1 to 0
        param2 = 0;                                 % Set param1 to 0

        X = data;                                   % Return unnormalized data
    
    case "minmax"
        
        switch nargin
            case 2                                  % Verify if there is predetermined param1 and param2
                param1 = min(data,[],2);            % Get the min matrix of the N features
                param2 = max(data,[],2);            % Get the max matrix of the N features
        end

        X = (data - param1)./(param2 - param1);     % Obtain the minmax normalization
      
    case "zscore"

        switch nargin
            case 2                                  % Verify if there is predetermined param1 and param2
                param1 = mean(data,2);              % Get the mean matrix of the N features
                param2 = std(data,0,2);             % Get the std matrix of the N features
        end
        
        X = (data - param1)./(param2);              % Obtain the zscore normalization

    end
end 

