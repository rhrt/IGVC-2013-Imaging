% CSSE463 - Lab1 Intro to Matlab and Image Processing
% 
%
% Author: Ander Solorzano
%
%
%
clc                     % clear the screen
clear all variables     % clear all saved variables
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%import the template image
tempImg = imread('Barrels/Templates/barrelTemp1','png');
imtool(tempImg);

%set all pixels greater than 120 to 255, and all less than 120 to 70.
index = find(tempImg()>=120);
tempImg(index) = 200;
% imtool(tempImg);

index2 = find(tempImg()<=120);
tempImg(index2) = 90;
imtool(tempImg);

% make a 3x3 neighborhood matrix
structureElt = strel('square', 3); % for erosion using 3x3 neighborhood

img = imopen(tempImg, structureElt);
imtool(img);

%save the image
imwrite(img,'Barrels/Templates/monoTemp1.png');