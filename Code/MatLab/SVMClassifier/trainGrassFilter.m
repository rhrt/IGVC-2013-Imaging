clear all
close all
clc

%grassDataName = inputdlg('Please enter grass data file name');
load('dataGrass');%grassDataName{1});
grassData = data;

%nonGrassDataName = inputdlg('Please enter non-grass data file name');
load('dataNonGrass');%nonGrassDataName{1});
nonGrassData = data;

grassData = double(reshape(grassData,size(grassData,1),3,1));
nonGrassData = double(reshape(nonGrassData,size(nonGrassData,1),3,1));
%grassData = grassData(1:1000:length(grassData),:);
%nonGrassData = nonGrassData(1:100:length(nonGrassData),:);

X = cat(1,grassData,nonGrassData);
[pos,~] = size(grassData);
[neg,~] = size(nonGrassData);
Y = cat(1,ones(pos,1),ones(neg,1)*(-1));


kernalParTests = 5;%5.0:5.0:100;
CTests = 50;% 5.0:5.0:200;

numTrials = length(kernalParTests) * length(CTests);
dataMat = zeros(numTrials,3);

trialNumber = 0;
bestAcc = 0;
for kernalpar = kernalParTests
    for C = CTests
        
        trialNumber = trialNumber+1;
        net = svm(size(X,2),'rbf',kernalpar,C);
        net = svmtrain(net,X,Y);
        
        grassResults = svmfwd(net,grassData);
        nonGrassResults = svmfwd(net,nonGrassData);
        
        accuracy = (length(find(grassResults==1)) + length(find(nonGrassResults==-1)))/(length(grassResults)+length(nonGrassResults));
        dataMat(trialNumber,:) = [accuracy,kernalpar,C];
        
        if accuracy > bestAcc
            bestNet = net;
            bestAcc = accuracy;
            bestTrial = trialNumber;
        end
        
        fprintf('Trial #%d of %d : acc = %f\n',trialNumber,numTrials,accuracy);
        
    end
end

save('bestNet','dataMat','bestAcc','bestTrial','bestNet')