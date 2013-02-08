function toyProblem()
% toyProblem.m
% Written by Matthew Boutell, 2006.
% Feel free to distribute at will.

clear all;

% We fix the seeds so the data sets are reproducible
seedTrain = 137;
seedTest = 138;
% This tougher data set is commented out.
%[xTrain, yTrain] = GenerateGaussianDataSet(seedTrain);
%[xTest, yTest] = GenerateGaussianDataSet(seedTest);

% This one isn't too bad at all
[xTrain, yTrain] = GenerateClusteredDataSet(seedTrain);
[xTest, yTest] = GenerateClusteredDataSet(seedTest);


% Add your code here.
% KNOWN ISSUE: the linear decision boundary doesn't work 
% for this data set at all. Don't know why...


net = svm(size(xTrain, 2), 'rbf', [100], 100);
net = svmtrain(net, xTrain, yTrain);
[detectedClasses, distances] = svmfwd(net, xTest);

for i = 1:length(yTrain)
    fprintf('Point %d, True class: %d, detected class: %d, distance: %0.2f\n', i, yTest(i), detectedClasses(i), distances(i))
end

x1ran = [0 25];
x2ran = [0 25];

f2 = figure;
plotboundary(net, x1ran, x2ran);
plotdata(xTrain, yTrain, x1ran, x2ran);
plotsv(net, xTrain, yTrain);
% plot(f2,xTrain,yTrain)
title(['SVM with rbf kernel: decision boundary (black) plus Support' ...
       ' Vectors (red)']);

% Run this on a trained network to see the resulting boundary 
% (as in the demo)
plotboundary(net, [0,20], [0,20]);

correctPos = length(find((yTest == 1) & (detectedClasses == 1)));
falsePos = length(find((yTest == -1) & (detectedClasses == 1)));
correctNeg = length(find((yTest == -1) & (detectedClasses == -1)));
falseNeg = length(find((yTest == 1) & (detectedClasses == -1)));

truePositiveRate = correctPos / (correctPos + falsePos);
falsePositiveRate = falsePos / (falsePos + correctNeg);

accuracy = (correctPos + correctNeg) / (correctPos + falsePos + correctNeg + falseNeg);


function plotdata(X, Y, x1ran, x2ran)
% PLOTDATA - Plot 2D data set
% 

hold on;
ind = find(Y>0);
plot(X(ind,1), X(ind,2), 'ks');
ind = find(Y<0);
plot(X(ind,1), X(ind,2), 'kx');
text(X(:,1)+.2,X(:,2), int2str([1:length(Y)]'));
axis([x1ran x2ran]);
axis xy;


function plotsv(net, X, Y)
% PLOTSV - Plot Support Vectors
% 

hold on;
ind = find(Y(net.svind)>0);
plot(X(net.svind(ind),1),X(net.svind(ind),2),'rs');
ind = find(Y(net.svind)<0);
plot(X(net.svind(ind),1),X(net.svind(ind),2),'rx');


function [x11, x22, x1x2out] = plotboundary(net, x1ran, x2ran)
% PLOTBOUNDARY - Plot SVM decision boundary on range X1RAN and X2RAN
% 

hold on;
nbpoints = 100;
x1 = x1ran(1):(x1ran(2)-x1ran(1))/nbpoints:x1ran(2);
x2 = x2ran(1):(x2ran(2)-x2ran(1))/nbpoints:x2ran(2);
[x11, x22] = meshgrid(x1, x2);
[~, x1x2out] = svmfwd(net, [x11(:),x22(:)]);
x1x2out = reshape(x1x2out, [length(x1) length(x2)]);
contour(x11, x22, x1x2out, [-0.99 -0.99], 'b-');
contour(x11, x22, x1x2out, [0 0], 'k-');
contour(x11, x22, x1x2out, [0.99 0.99], 'g-');
