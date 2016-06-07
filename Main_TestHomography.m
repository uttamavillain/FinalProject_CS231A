%Test homography

% SETUP
clear all; close all; clc;

I1 = imread('Data/e1.jpg');
I2 = imread('Data/e2.jpg');

I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

[up, up_] = getFourCorrespondance(I1, I2);

[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(up_',up','projective');

outputView = imref2d(size(I1));
Ir = imwarp(I2,tform,'OutputView',outputView);
imshowpair(I1, Ir, 'montage');

initial_H = getInitialHomography(up,up_);

I3 = getTransformedImage(initial_H, I2);

figure;
imshowpair(I1,I3,'montage')

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure; showMatchedFeatures(I1,I2,matchedPoints1.Location,matchedPoints2.Location);
title('Raw feature matches');

[refinedPoints1, refinedPoints2] = removeOutliers(initial_H, matchedPoints1.Location, matchedPoints2.Location, 50);
size(refinedPoints1)

if size(refinedPoints1,1) >= 4
    figure; showMatchedFeatures(I1,I2,refinedPoints1,refinedPoints2);
    title('After removing outliers');
    H = refineHomography(refinedPoints1, refinedPoints2);
else
    H = initial_H;
end

I3 = getTransformedImage(H, I2);

figure;
imshowpair(I1,I3,'montage');

imshow(imabsdiff(I1,I3));