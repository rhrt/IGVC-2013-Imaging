clear all;
clc;

%img = imread('img39685.png');
%img = imread('img14772.png');
%img = imread('img14738.png');
%img = imread('img14716.png');
%img = imread('img14681.png');
%img = imread('img14661.png');
%img = imread('img14636.png'); % MISSES A HORIZONTAL LINE
img = imread('img14607.png'); % MISSES TWO HORIZONTAL LINES
%img = imread('img14579.png');
%img = imread('img14553.png');
%img = imread('img14525.png'); % MISSES DIAGONAL
%img = imread('img14502.png'); % MISSES SHORT DIAGONAL
%img = imread('img14467.png');
%img = imread('img14381.png');
%img = imread('img14331.png');
%img = imread('img13538.png');
%img = imread('img13503.png'); % MISSES ARC
%img = imread('img13462.png'); % MISSES VERTICAL LINE
%img = imread('img12941.png'); % MISSES LEFT (FADED) VERTICAL LINE
%img = imread('img12911.png'); % MISSES SHORT LEFT VERTICAL LINE
%img = imread('img12861.png'); % MISSES LEFT (FADED) LINE
%img = imread('img12810.png'); % MISSES RIGHT FADED LINE
%img = imread('img12775.png'); % MISSES LEFT SHORT LINE
%img = imread('img12731.png');
%img = imread('img12688.png');
%img = imread('img12653.png');
img = img(120:360,:,:);

hsvimg = rgb2hsv(img);
b = hsvimg(:,:,3);

binimg = zeros(size(img(:,:,1)));

m = 20;

for row = m+1:size(binimg,1)-m
    for col = m+1:size(binimg,2)-m
        dplus = b(row,col) - b(row,col+m);
        dminus = b(row,col) - b(row,col-m);
        if dplus > 0 && dminus > 0
            binimg(row,col) = dplus + dminus;
        end
    end
end

m = 50;

for col = m+1:size(binimg,2)-m
    for row = m+1:size(binimg,1)-m
        dplus = b(row,col) - b(row,col+m);
        dminus = b(row,col) - b(row,col-m);
        if dplus > 0 && dminus > 0
            if binimg(row,col) > 0
                binimg(row,col) = ((dplus + dminus) + binimg(row,col)) / 2;
            else
                binimg(row,col) = dplus + dminus;
            end
        end
    end
end

binimg = binimg > 0.35 & hsvimg(:,:,1) < 0.9 & hsvimg(:,:,1) > 0.1;

rotI = img;
BW = binimg;
[H,T,R] = hough(BW);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% Find lines and plot them
lines2 = houghlines(BW,T,R,P,'FillGap',25,'MinLength',25);
imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines2)
   xy = [lines2(k).point1; lines2(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',5,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',5,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines2(k).point1 - lines2(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end