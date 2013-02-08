function [ distance ] = getColorDistance( color1,color2 )
    distance = sum( (color1-color2).^2);
end

