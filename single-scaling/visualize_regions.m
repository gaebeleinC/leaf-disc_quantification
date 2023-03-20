function[onlyD] =  visualize_regions(storage_name2,image_rgb,mask)
    

onlyD = image_rgb;
    R = onlyD(:,:,1);
    G = onlyD(:,:,2);
    B = onlyD(:,:,3);
    
    R(mask ~=1) = 0;
    G(mask ~=1) = 0;
    B(mask ~=1) = 0;
    
    onlyD(:,:,1) = R;
    onlyD(:,:,2) = G;
    onlyD(:,:,3) = B;
    

    imwrite(onlyD,storage_name2); 
end

