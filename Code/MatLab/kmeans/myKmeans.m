function [meansImg,classMap,classes] = myKmeans(img,k)
    img = double(img);
    
    longImg = reshape(img,size(img,1)*size(img,2),3,1);
    [idx,classes] = kmeans(longImg,k,'MaxIter',500,'replicates',5);
    
    classMap = reshape(idx,size(img,1),size(img,2));
    
    R = zeros(size(img,1),size(img,2));
    G = zeros(size(R));
    B = zeros(size(R));
    
    for i = 1:k
        inds = find(classMap == i);
        R(inds) = classes(i,1);
        G(inds) = classes(i,2);
        B(inds) = classes(i,3);
    end
    
    meansImg = uint8(cat(3,R,G,B));
    classes = uint8(classes);
    
end