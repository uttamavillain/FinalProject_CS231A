function [ x, x_ ] = removeOutliers(H, matchPoints1, matchPoints2, thresh)

x = zeros(size(matchPoints1));
x_ = zeros(size(matchPoints2));

WmatchPoints2 = horzcat(matchPoints2,ones(size(matchPoints2,1),1));
WmatchPoints2 = H*WmatchPoints2';
WmatchPoints2 = WmatchPoints2./repmat(WmatchPoints2(3,:),[size(WmatchPoints2,1),1]);
WmatchPoints2 = WmatchPoints2';
WmatchPoints2 = WmatchPoints2(:,1:2);

index = 0;

for i = 1:size(matchPoints1,1)
    if(pdist2(matchPoints1(i,:),WmatchPoints2(i,:)) < thresh)
        index = index+1;
        x(index,:) = matchPoints1(i,:);
        x_(index,:) = matchPoints2(i,:);
    end
end

x = x(1:index,:);
x_ = x_(1:index,:);

end