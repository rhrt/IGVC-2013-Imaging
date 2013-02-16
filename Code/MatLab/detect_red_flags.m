function [ bin_img ] = detect_red_flags(img)
    % Outputs pixel locations of red flags in the given image
    hsv_img = rgb2hsv(img);
    H = hsv_img(:,:,1);
    bin_img = H > 0.9 | H < .1;
    bin_img = imdilate(bin_img, strel('square', 3));
end

