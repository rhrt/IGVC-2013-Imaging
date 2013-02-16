clear all
close all
clc

filename = inputdlg('Please enter file name');
filename = filename{1};

try 
    load(filename)
catch
    data = zeros(0,1,3);
end

questans = questdlg('Would you like to examine another picture?','Another File?','Yes','No','Yes');

while strcmp(questans,'Yes')
    [file,path] = uigetfile(fullfile('C:\Users\Donnie Quamme\Dropbox\IGVC Photos','*.png;*.bmp;*.jpg'),'select file');
    
    img = imread([path,file]);
    imshow(img);
    
    dataPoints = ginput();
    
    for i = 1:2:size(dataPoints,1)
        if dataPoints(i,2)<dataPoints(i+1,2)
            yRange = dataPoints(i,2):dataPoints(i+1,2);
        else
            yRange = dataPoints(i+1,2):dataPoints(i,2);
        end
        
        if dataPoints(i,1)<dataPoints(i+1,1)
            xRange = dataPoints(i,1):dataPoints(i+1,1);
        else
            xRange = dataPoints(i+1,1):dataPoints(i,1);
        end
        
        points = img(int32(yRange),int32(xRange),:);
        data = cat(1,data,reshape(points,size(points,1)*size(points,2),1,3));
    end
    
    questans = questdlg('Would you like to examine another picture?','Another File?','Yes','No','Yes');
end

save(filename,'data')
