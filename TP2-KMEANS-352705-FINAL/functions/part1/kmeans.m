function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters for each points.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEMPLATE CODE (DO NOT MODIFY)
% Auxiliary Variable
[D, N] = size(X);
d_i    = zeros(K,N);
k_i    = zeros(1,N);
r_i    = zeros(K,N);
if plot_iter == [];plot_iter = 0;end
tolerance = 1e-6;
MaxTolIter = 10;

% Output Variables
Mu     = zeros(D, K);
labels = zeros(1,N);

%% INSERT CODE HERE

Mu_init =  kmeans_init(X, K, init);

%% TEMPLATE CODE (DO NOT MODIFY)
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end


%% INSERT CODE HERE

Mu = Mu_init;                                           % Initialize values
tol_iter = 0;
iter = 0;

while 1
    
    if sum(isnan(Mu(:)))>0                              % Verify if there is an empty cluster
        Mu_init = kmeans_init(X, K, init);              % Reinitialize Mu_init if there is an empty cluster
        Mu = Mu_init;                                   % Set new initial Mu to Mu
        iter = 0;                                       % Reset iter
    end
    
    d_i = distance_to_centroids(X, Mu, type);           % Obtain the distance to the centroids
    
    r_i = d_i - repmat(min(d_i,[],1),K,1);              % Identify the minimum distances for each datapoint
    r_i(r_i~=0)=inf; r_i(r_i==0)=1; r_i(r_i~=1)=0;      % Adjust the matrix to show minimums in 1 and other values in 0

    clust_sizes = sum(r_i,2);                           % Get the sizes of each cluster
    
    r_i = r_i.*clust_sizes;                             % Multiply r_i to the sizes of each cluster
    r_i(r_i==0) = inf;                                  % Set zeroes to inf to simplify identification of cluster with smallest size
    r_i = r_i - repmat(min(r_i,[],1),K,1);              % Identify centroid with the smallest winning cluster size for each datapoint
    r_i(r_i~=0)=inf; r_i(r_i==0)=1; r_i(r_i~=1)=0;      % Adjust the matrix to show minimums in 1 and other values in 0
    
    Mu_previous = Mu;                                   % Set Mu_previous with the actual value of Mu
   
    for j=1:K
        Mu(:,j) = sum(r_i(j,:).*X,2)/sum(r_i(j,:),2);   % Recompute the centroids
    end
    
    [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, tol_iter, MaxIter, MaxTolIter, tolerance);

    if has_converged                                    % Check convergence to exit loop
        break;
    else
        iter = iter+1;                                  % Increase iteration value
    end
end

[~,labels] = max(r_i,[],1);                             % Get final value of labels

%% TEMPLATE CODE (DO NOT MODIFY)
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroids(Mu',colors);
end


end