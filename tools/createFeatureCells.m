function [X, Y] = createFeatureCells(X1, X2, class1, class2)
X = cat(1,X1,X2);
Y = ones(size(X,1),1);
Y(1:size(X1,1)) = -1;
Y = categorical(Y, [-1, 1], {class1,class2});
end