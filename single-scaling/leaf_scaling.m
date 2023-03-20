%scaling function for plants in a pot

function [single_pixel] = leaf_scaling(image_rgb, runVar)
    scale = 70 ; %scaling in mm
    
    if runVar = 0
         msgbox(['-----------------------------SCALING ----------------------------- Leftclick on the upper left corner of the well plate, below the slant.' ...
            'Then leftclick on the lower left corner of  the plate above the slant.' ...
           'Then press enter.']);
    end
        
    imshow(image_rgb)
    [xi,yi] = getpts;
    close
    
   
    pointA = [xi(1), yi(1)];
    pointB = [xi(2), yi(2)];
    dist  = sqrt(sum((pointA - pointB) .^ 2));
         

  
    single_pixel = scale / dist; %scaling in mm
end