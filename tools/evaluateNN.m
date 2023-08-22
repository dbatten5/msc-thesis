function [AUC,accuracy,ROCX,ROCY] = evaluateNN(net,XTest,YTest,posClass)
[labels,scores] = classify(net,XTest);
[ROCX,ROCY,~,AUC] = perfcurve(YTest, scores(:,1), posClass);
accuracy = mean(labels==YTest);
end
