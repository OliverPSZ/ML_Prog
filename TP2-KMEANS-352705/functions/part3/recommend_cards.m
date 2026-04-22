function [cards] = recommend_cards(deck, Mu, type)
%RECOMMAND_CARDS Recommands a card for the deck in input based on the
%centroid of the clusters
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N, 1) a deck of card
%       o Mu : (M x k) the centroids of the k clusters
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o cards : a set of cards recommanded to add to this deck
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,closest_k] = min(deck_distance(deck, Mu, type));     % Get the id of the closest cluster 
cluster_cl = Mu(:,closest_k);                           % Get the data from the closest cluster
idx = find(Mu(:,closest_k));                            % Get the indexes where Mu is not zero
cards_unsorted = [idx,cluster_cl(idx)];                 % Get unsorted matrix with Mu values that are not zeor and their indexes
[~,idx_cards] = sort(cards_unsorted(:,2),'descend');    % Get indexes of sorted values
cards = cards_unsorted(idx_cards,1);                    % Get card values

end

