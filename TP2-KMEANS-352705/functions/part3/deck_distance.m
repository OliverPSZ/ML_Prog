function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deck_subset = find(deck);                                                    % Find subset indexes where deck values are not 0
dist =  distance_to_centroids(deck(deck_subset), Mu(deck_subset,:), type);   % Find the distance from subset of deck and subset of Mu

end

