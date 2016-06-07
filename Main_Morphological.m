%This is the main script to recover the blackboard

% SETUP
clear all; close all; clc;

original  = rgb2gray(imread('data/g1.jpg'));
imshow(original);
title('Base image');
distorted = rgb2gray(imread('data/g2.jpg'));
figure; imshow(distorted);
title('Transformed image');

[up, up_] = getFourCorrespondance(original, distorted);

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

I = imabsdiff(original,Ir);
figure; 
imshow(I);

threshI = im2bw(I,graythresh(I));
erodedI = imerode(threshI,strel('disk',3,4));
dilatedI = imdilate(erodedI,strel('disk',25,4));
filledI = imfill(dilatedI,'holes');
filledI = imerode(filledI,strel('disk',22,4));
figure; 
imshowpair(I,filledI,'montage');

imshow(imclearborder(filledI,4));

filledI(1:30,1:end) = 0;
filledI(end-30:end,1:end) = 0;
filledI(1:end,1:30) = 0;
filledI(1:end,end-30:end) = 0;

label = bwlabel(filledI);
figure; 
imshow(label2rgb(label));

[bbr, bbc] = find(label==0);
[o1r, o1c] = find(label==1);
[o2r, o2c] = find(label==2);

bbM = mean(original(sub2ind(size(original), bbr, bbc)));
o1M = mean(original(sub2ind(size(original), o1r, o1c)));
o2M = mean(original(sub2ind(size(original), o2r, o2c)));

%o2 is closer to bb so o1 is coming from 1st image
if abs(bbM - o1M) > abs(bbM - o2M)
    new = copyFrom(Ir,original,[o1r, o1c],0);
else
    new = copyFrom(Ir,original,[o2r, o2c],0);
end

figure;
imshow(new);