function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (height x width x 3), an image of size height x width over RGB channels
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x width x 3) The projection of the image on the eigenvectors
%       o ApList : (p x height x 3) The projection matrices for each channels
%       o muList : (height x 3) The mean vector for each channels

for i=1:size(img,3)

    [muList(:,i), C, EigenVectors, EigenValues] = compute_pca(img(:,:,i));                  % Compute PCA for RGB individually
    [cimg(:,:,i), ApList(:,:,i)] = project_pca(img(:,:,i), muList(:,i), EigenVectors, p);   % Project PCA for RGB individually

end
end

