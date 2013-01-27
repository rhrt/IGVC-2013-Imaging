clear all
close all
clc

img = imread('img14681.png');
%img = imread('img39685.png');
%img = imread('9.png');

%gaussFilter = fspecial('average',[10,10]);
HSVImg = rgb2hsv(img);

noGrassImg = img;
noGrassImg(:,:,3) = noGrassImg(:,:,3) - (0.5) * noGrassImg(:,:,2);
%HSVImg = rgb2hsv(noGrassImg);
%noGrassImg = rgb2gray(noGrassImg);

imshow(noGrassImg(:,:,3));

H = HSVImg(:,:,1);
%H = filter2(gaussFilter,H);
S = HSVImg(:,:,2);
%S = filter2(gaussFilter,S);
V = HSVImg(:,:,3);
%V = filter2(gaussFilter,V);

mask = zeros(size(H));

inds = find((H>0.45)&(H<0.80)&(S<0.40)&(V>0.7)&(V<0.90));
mask(inds) = 1;
imshow(mask);

%mask2 = imdilate(mask,strel('disk',1));

%imshow(mask2)