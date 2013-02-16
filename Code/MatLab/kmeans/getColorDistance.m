function [ distance ] = getColorDistance( color1,color2 )
    distance = sqrt(sum( (double(color1)-double(color2)).^2));
end

