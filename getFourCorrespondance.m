function [ x, x_ ] = getFourCorrespondance( I1, I2 )

x = zeros(2,4);
x_ = zeros(2,4);

figure;
title('Click a point on this image'); axis image;
%Take in corner input

for i = 1:4
    imagesc(I1); colormap(gray);
    x(:,i) = ginput(1);
    
    imagesc(I2); colormap(gray);
    x_(:,i) = ginput(1);
    
title('Click a point on this image'); axis image;
end

end

