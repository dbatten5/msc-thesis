function [projected,pcaCoeffs] = projectPCA(X,minVariance)
[coeff,~,~,~,explained] = pca(X);

% Determine the number of principal components needed to capture the variance threshold
totalVariance = cumsum(explained);
numComponents = find(totalVariance >= minVariance,1);

% Select the top-k principal component coefficients
pcaCoeffs = coeff(:,1:numComponents);

% Project the data onto the new subspace
projected = X * pcaCoeffs;
end
