function [H corrPtIdx] = findHomography(pts1,pts2)
% [H corrPtIdx] = findHomography(pts1,pts2)
%	Find the homography between two planes using a set of corresponding
%	points. PTS1 = [x1,x2,...;y1,y2,...]. RANSAC method is used.
%	corrPtIdx is the indices of inliers.
%	Yan Ke @ THUEE, 20110123, xjed09@gmail.com


coef.minPtNum = 4;
coef.iterNum = 30;
coef.thDist = 4;
coef.thInlrRatio = .1;
[H corrPtIdx] = ransac1(pts1,pts2,coef,@solveHomo,@calcDist);

end
