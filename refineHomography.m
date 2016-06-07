function [model] = refineHomography(X, Xp)

    X = horzcat(X,ones(size(X,1),1));
    Xp = horzcat(Xp,ones(size(Xp,1),1));

    X = X';
    Xp = Xp';

    iter=1000;
    pixelThresh=5;
    inliers=zeros(1,length(X(1,:)));
    model=eye(3);
    max = 0;

    % X is a N x 3 matrix where each row is the homogeneous coordinates of a
    % keypoint in image1, while Xp is the corresponding points in image2.

    %Main loop, picks a set of 4 random points, calculates homography,
    %calculates inliers.

    for interation=1:iter

        %pick a random set of matches
        randIndex = randperm(size(X,2),4);
        a_ = X(:,randIndex(1)); b_ = X(:,randIndex(2)); c_ = X(:,randIndex(3)); d_ = X(:,randIndex(4));
        a = Xp(:,randIndex(1)); b = Xp(:,randIndex(2)); c = Xp(:,randIndex(3)); d = Xp(:,randIndex(4));

        %Calculate model
       A = [-a(1) -a(2)  -1    0     0    0  a(1)*a_(1)  a(2)*a_(1)  a_(1)
             0      0     0 -a(1) -a(2)  -1  a(1)*a_(2)  a(2)*a_(2)  a_(2)

           -b(1) -b(2)  -1     0     0    0  b(1)*b_(1)  b(2)*b_(1)  b_(1)
             0      0    0  -b(1) -b(2)  -1  b(1)*b_(2)  b(2)*b_(2)  b_(2)

           -c(1) -c(2)  -1    0     0     0  c(1)*c_(1)  c(2)*c_(1)  c_(1)
             0      0    0  -c(1) -c(2)  -1  c(1)*c_(2)  c(2)*c_(2)  c_(2)

           -d(1) -d(2)  -1    0     0     0  d(1)*d_(1)  d(2)*d_(1)  d_(1)
             0      0    0  -d(1) -d(2)  -1  d(1)*d_(2)  d(2)*d_(2)  d_(2)];

       h = null(A);
       h = h/h(9);
       H = [h(1), h(2), h(3);
            h(4), h(5), h(6);
            h(7), h(8), h(9);];

        %Calculate reprojection error
        %Calculate inliers
        %Keep track of best model

        tempInliers = zeros(1,length(X(1,:)));
        count = 0;
        for i = 1:size(X,2)
            x = X(:,i); x = x/x(3);
            x_ = H*Xp(:,i); x_ = x_/x_(3);
            error = norm(x-x_);
            if error < pixelThresh
                count = count + 1;
                tempInliers(count) = i;
            end
        end

        if max<count
            max = count;
            inliers = tempInliers(1,1:max);
            model = H;
        end

    end

end