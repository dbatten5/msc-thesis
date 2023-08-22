function [XTrain, YTrain, XValidation, YValidation] = createValidationSplit(X, Y, nva)
arguments
X
Y
nva.Split = 0.3
end

numSamples = size(X, 1);

cv = cvpartition(numSamples, 'HoldOut', nva.Split);
trainIndices = training(cv);
validationIndices = test(cv);

XTrain = X(trainIndices,:);
YTrain = Y(trainIndices);

XValidation = X(validationIndices,:);
YValidation = Y(validationIndices);
end