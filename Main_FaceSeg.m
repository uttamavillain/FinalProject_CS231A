% SETUP
clear all; close all; clc;

original  = rgb2gray(imread('data/g1.jpg'));
imshow(original);
title('Base image');
distorted = rgb2gray(imread('data/g2.jpg'));
figure; imshow(distorted);
title('Transformed image');

%[up, up_] = getFourCorrespondance(original, distorted);

ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal,validPtsOriginal] = extractFeatures(original, ptsOriginal);
[featuresDistorted,validPtsDistorted] = extractFeatures(distorted,ptsDistorted);

index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
figure; showMatchedFeatures(original,distorted,matchedPtsOriginal,matchedPtsDistorted);
title('Matched SURF points,including outliers');

matchedPtsOriginalLocation = vertcat(matchedPtsOriginal.Location,up');
matchedPtsDistortedLocation = vertcat(matchedPtsDistorted.Location,up_');

[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistortedLocation,matchedPtsOriginalLocation,'projective','MaxNumTrials',2000);
figure; showMatchedFeatures(original,distorted,inlierPtsOriginal,inlierPtsDistorted);
title('Matched inlier points');

outputView = imref2d(size(original));
Ir = imwarp(distorted,tform,'OutputView',outputView);
figure; imshow(Ir);
title('Recovered image');

[bbox] = getFaceBoundingBox(Ir,1);

new = copyFrom(original,Ir,getPersonBox(Ir,bbox(9,:)),1);

imshow(new);