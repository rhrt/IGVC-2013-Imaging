function mask = filterGrass(rgbImg)
    rgbImg = double(rgbImg);
    [height,width,~] = size(rgbImg);
    
    img = reshape(rgbImg,height*width,3,1);
    
    load('grassNet')
    mask = svmfwd(net,img);
    
    mask = reshape(mask,height,width,1);
end