clear all;
clc;

%img = imread('img39685.png'); % HSV
%img = imread('img14772.png'); % HSV
%img = imread('img14738.png'); % HSV
%img = imread('img14716.png'); % HSV
%img = imread('img14681.png'); % HSV
%img = imread('img14661.png'); % HSV
%img = imread('img14636.png'); % HSV+GRASS
%img = imread('img14607.png'); % HSV+GRASS
img = imread('img14579.png'); % HSV B
%img = imread('img14553.png'); % HSV+GRASS
%img = imread('img14525.png'); % HSV B
%img = imread('img14502.png'); % HSV (mostly)
%img = imread('img14467.png'); % HSV
%img = imread('img14381.png'); % HSV
%img = imread('img14331.png'); % HSV
%img = imread('img13538.png'); % HSV
%img = imread('img13503.png'); % HSV
%img = imread('img13462.png'); % HSV (mostly)
%img = imread('img12941.png'); % HSV (missing left line)
%img = imread('img12911.png'); % HSV (mostly)
%img = imread('img12861.png'); % HSV
%img = imread('img12810.png'); % HSV (mostly)
%img = imread('img12775.png'); % HSV (mostly)
%img = imread('img12731.png'); % HSV
%img = imread('img12688.png'); % HSV
%img = imread('img12653.png'); % HSV
%img = imread('img12617.png'); % HSV
%img = imread('img11981.png');
%img = imread('img11814.png');
%img = imread('img10226.png'); % HSV
%img = imread('img10111.png'); % HSV
%img = imread('img10016.png'); % HSV B
%img = imread('img9736.png'); % B
%img = imread('img9701.png'); % HSV B
%img = imread('img9672.png'); % HSV B
%img = imread('img9643.png'); % HSV B
%img = imread('img9615.png'); % HSV B
%img = imread('img9575.png'); % HSV (mostly)
%img = imread('img9474.png'); % HSV
%img = imread('img9376.png'); % HSV B
height = size(img, 1);
start = height/3;
finish = height - 30;
if mod(finish - start + 1, 2) == 1
    start = start + 1;
end
img = img(start:finish,:,:);

white_lines = detect_white_lines(img, 10, 30);

figure(1);
imshow(img);

figure(2);
imshow(white_lines);

imshow(white_lines);