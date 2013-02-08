function [mask,meansImg,classes] = filterGrass(img)
%     filt = fspecial('gaussian',[5 5]);
%     img(:,:,1) = filter2(filt,img(:,:,1));
%     img(:,:,2) = filter2(filt,img(:,:,3));
%     img(:,:,3) = filter2(filt,img(:,:,3));

    load('dataGrassClasses');
    numGrassClasses = size(grassClasses,1);
    
    k = 5;
    maxDist = 1;
    
    [meansImg,classMap,classes] = myKmeans(img,k);
    
    for i = 1:k
        for j = 1:numGrassClasses
            if getColorDistance(classes(i,:),grassClasses(j,:)) < maxDist
                classMap(classMap == i) = 0;
            end
        end
    end
    
    mask = zeros(size(classMap));
    mask(classMap == 0) = 1;
    mask = boolean(mask);

end