clear all
close all
clc

[file,path] = uigetfile();
img = imread([path,file]);
img = img(size(img,1)/3:end-30,:,:);
%img = imread('C:\Users\quammebd\Dropbox\IGVC Photos\IGVC Test Field Images 2\7.png');
resizeFactor = 8;
img = imresize(img,1/resizeFactor);

figure(1);
imshow(imresize(img,resizeFactor));

%img = rgb2hsv(img);

figure(2);
[mask,meansImg,classes] = filterGrass(img);
imshow(imresize(uint8(meansImg),resizeFactor));
figure(3);
imshow(imresize(mask,resizeFactor));