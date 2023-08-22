function [AUC,accuracy,ROCX,ROCY] = evaluateSVM(model,XTest,YTest)
[labels,scores] = predict(model,XTest);
[ROCX,ROCY,~,AUC] = perfcurve(YTest, scores(:,1), model.ClassNames(1));
accuracy = mean(labels==YTest);
end

