function [ I3 ] = getTransformedImage( H, I2 )

I3 = ones(size(I2));
for i=1:size(I2,1)
    for j=1:size(I2,2)
        loc = H * [i j 1]';
        loc = loc/loc(3);
        loc = round(loc);
        x = loc(1); y = loc(2);
        if(loc>0 & x<=size(I2,1) & y<=size(I2,2))
            I3(i,j) = I2(x,y);
        end
    end
end

I3 = uint8(I3);

end

% I3 = ones(size(I2));
% for i=1:size(I2,1)
%     for j=1:size(I2,2)
%         loc = H * [j i 1]';
%         loc = loc/loc(3);
%         loc = round(loc);
%         x = loc(2); y = loc(1);
%         if(loc>0 & x<=size(I2,1) & y<=size(I2,2))
%             I3(i,j) = I2(x,y);
%         end
%     end
% end