function [bin_line_img] = detect_white_lines(img, vertical_line_width, horizontal_line_width)
    % Detects white lane lines in captured images
    % Returns a binary matrix marking pixels detected as lane markings
    grass = imresize(filterGrass(imresize(img, .5)), 2) > 0;
    hsv_img = rgb2hsv(img);
    brightness = hsv_img(:, :, 3); % BRIGHTNESS IS VALUE BAND OF HSV IMAGE
    
    % USING RELATIVE BRIGHTNESS ALGORITHM TO DETECT WHITE LINES
    
    whole_filter = zeros(2 * horizontal_line_width  +1, 2 * vertical_line_width + 1);
    whole_filter(horizontal_line_width + 1, vertical_line_width + 1) = 4;
    whole_filter(1, vertical_line_width + 1) = -1;
    whole_filter(2 * horizontal_line_width + 1, vertical_line_width + 1) = -1;
    whole_filter(horizontal_line_width + 1, 1) = -1;
    whole_filter(horizontal_line_width + 1, 2 * vertical_line_width + 1) = -1;
    
    bin_img = filter2(whole_filter, brightness);
    bin_img = ((bin_img > 0) .* ~grass) | (brightness > 0.9);
    
    % IDENTIFY LINES USING HOUGH TRANSFORM
    [H, T, R] = hough(bin_img);
    P  = houghpeaks(H, 5, 'threshold', ceil(0.3 * max(H(:))));
    lines = houghlines(bin_img, T, R, P, 'FillGap', 25, 'MinLength', 25);
    
    % MARK LINE PIXELS IN BINARY IMAGE
    line_width = 15;
    bin_line_img = zeros(size(img));
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       slope = (1 / ((xy(2, 2) - xy(1, 2)) / (xy(2, 1) - xy(1, 1))));
       yStart = xy(1, :);
       yEnd = xy(2, :);
       bin_line_img(yStart(2), yStart(1)) = 1;
       bin_line_img(yEnd(2), yEnd(1)) = 1;
       if abs(slope) < 2 % PLOTTING MORE VERTICAL LINES
           if yStart(2) > yEnd(2)
               yEnd = xy(1, :);
               yStart = xy(2, :);
           end
           for y = yStart(2)+1:yEnd(2)-1
               lineCenter = yStart(1) + int32(slope * (y - yStart(2) - 1));
               cols = max(1, lineCenter - (line_width / 2)):min(size(bin_img, 2), lineCenter + (line_width/2));
               bin_line_img(y, cols, :) = 255;
           end
       else % PLOTTING FLATTER LINES
           if yStart(1) > yEnd(1)
               yEnd = xy(1, :);
               yStart = xy(2, :);
           end
           for x = yStart(1) + 1:yEnd(1) - 1
               lineCenter = yStart(2) + int32(1 / slope * (x - yStart(1) - 1));
               rows = max(1, lineCenter - (line_width / 2)):min(size(bin_img, 2), lineCenter + (line_width / 2));
               bin_line_img(rows, x, :) = 255;
           end
       end
    end

end

