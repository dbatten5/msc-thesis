function [projected,pcaCoeffs] = projectPCA(X,minVariance,NameValueArgs)
arguments
    X
    minVariance = false
    NameValueArgs.NumComponents = false
end

if NameValueArgs.NumComponents
    pcaCoeffs = pca(X,"NumComponents",NameValueArgs.NumComponents);
    projected = X * pcaCoeffs;
else
    [coeff,~,~,~,explained] = pca(X);
    
    % Determine the number of principal components needed to capture the variance threshold
    totalVariance = cumsum(explained);
    numComponents = find(totalVariance >= minVariance,1);
    
    % Select the top-k principal component coefficients
    pcaCoeffs = coeff(:,1:numComponents);
    
    % Project the data onto the new subspace
    projected = X * pcaCoeffs;
end
end
