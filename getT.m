function T = getT(p)
Xavg = mean(p(1,:));
Yavg = mean(p(2,:));
tempp = p-repmat([Xavg; Yavg; 0],1,size(p,2));
d=sqrt(sum(sum(tempp.^2))) / (size(p,2)*sqrt(2));
T = [1/d 0 -Xavg/d; 0 1/d -Yavg/d; 0 0 1];
end