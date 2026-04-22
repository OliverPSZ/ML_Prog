function [Yest] = gmm_classifier(Xtest, models, labels)
%GMM_CLASSIFIER Classifies datapoints of X_test using ML Discriminant Rule
%   input------------------------------------------------------------------
%
%       o Xtest    : (N x M_test), a data set with M_test samples each being of
%                           dimension N, each column corresponds to a datapoint.
%       o models    : (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels    : (1 x N_classes) unique labels of X_test.
%   output ----------------------------------------------------------------
%       o Yest  :  (1 x M_test), a vector with estimated labels y \in {0,...,N_classes}
%                   corresponding to X_test.
%%

for i=1:length(labels)
    for j=1:size(models(i).Priors,2)
        cond_dens(j,:) = models(i).Priors(j)*gaussPDF(Xtest, models(i).Mu(:,j), models(i).Sigma(:,:,j));   % Get conditional densities
    end
    p_i(i,:) = sum(cond_dens,1);        % Sum conditional densities
end
[~,c_i] = min(-log(p_i),[],1);          % Get index from discriminant rule assuming equal class distribution
Yest = labels(c_i);                     % Get vector of estimated labels

end