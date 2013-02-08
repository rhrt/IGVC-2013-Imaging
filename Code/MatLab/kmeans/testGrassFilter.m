clear all
close all
clc

[file,path] = uigetfile();
img = imread([path,file]);
img = imresize(img,0.5);

figure(1);
imshow(img);

figure(2);
[mask,meansImg,classes] = filterGrass(img);
imshow(meansImg);
figure(3);
imshow(mask);