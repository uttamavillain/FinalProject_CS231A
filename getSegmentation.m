function [ binaryMap ] = getSegmentation( I1, I2 )

[featureVector, hogVisualization] = extractHOGFeatures(I1);

size(featureVector)
size(hogVisualization)

%   figure;
%     imshow(I1); hold on;
%     plot(hogVisualization);

end

