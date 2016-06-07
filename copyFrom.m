function [ new ] = copyFrom( from, to, points, bb)
% figure;
% imshow(from);
hold on;
    new = to;
    if bb
        for i = (repmat(points(1),1,points(3))) + (1:points(3))
            for j = (repmat(points(2),1,points(4))) + (1:points(4))
                new(j,i) = from(j,i);
            end
        end
    else
        for i = 1:size(points,1)
            new(points(i,1),points(i,2)) = from(points(i,1),points(i,2));
        end
    end
end
