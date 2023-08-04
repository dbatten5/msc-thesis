function [XTrain, YTrain, XValidation, YValidation] = createValidationSplit(X, Y, nva)
arguments
X
Y
nva.split = 0.3
end

numSamples = size(X, 1);

cv = cvpartition(numSamples, 'HoldOut', nva.split);
trainIndices = training(cv);
validationIndices = test(cv);

XTrain = X(trainIndices,:);
YTrain = Y(trainIndices);

XValidation = X(validationIndices,:);
YValidation = Y(validationIndices);
end