function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:size(unique(class_labels),2)
    for j=1:size(unique(cluster_labels),2)
            class = class_labels; class(class~=i)=0;            
            cluster = cluster_labels; cluster(cluster~=j)=0;
            n_ik(j,i) = sum((cluster.*class)~=0);
            k(j,:) = sum(cluster_labels==j);
    end
    c_i(:,i) = sum(class_labels==i);
end

R = n_ik./c_i;
P = n_ik./k;
F1 = (2*(R.*P))./(R+P);
F1(isnan(F1))=0;
F1_overall=sum((c_i./length(class_labels)).*max(F1,[],1));

end
