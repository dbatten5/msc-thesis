function [AUC,accuracy,ROCX,ROCY] = evaluateRNN(net,XTest,YTest,posClass,miniBatchSize)
[labels,scores] = classify(net,XTest, ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest");
[ROCX,ROCY,~,AUC] = perfcurve(YTest, scores(:,1), posClass);
accuracy = mean(labels==YTest);
end
