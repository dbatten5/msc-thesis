function accuracy = testModel(testMatrix,class,model)
numTestSamples = size(testMatrix,1);
labels = predict(model,testMatrix);
accuracy = sum(labels==class)/numTestSamples;
end