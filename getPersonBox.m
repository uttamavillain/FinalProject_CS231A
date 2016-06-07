function [ personbox ] = getPersonBox(im, bbox )

    width = bbox(3);
    height = bbox(4);

    startx = bbox(1) + floor(width/2);
    if(bbox(2)-20 <= 0)
        starty = 1;
    else
        starty = bbox(2)-30;
    end

    widthScale = 2;
    heightScale = 5;

    if startx - (widthScale * width) <= 0
        personbox(1) = 1;
    else
        personbox(1) = startx - (widthScale * width);
    end

    personbox(2) = starty;
startx + (widthScale * width * 2)
    if(startx + (widthScale * width * 2) > size(im,2))
        personbox(3) = size(im,1) - startx;
    else
        personbox(3) = widthScale * width * 2;
    end

    if(starty + (heightScale*height) > size(im,1))
        disp('vijay')
        personbox(4) = size(im,2) - starty;
    else
        personbox(4) = heightScale * height;
    end

end

