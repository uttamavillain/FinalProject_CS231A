function [ H ] = getInitialHomography( x, x_ )

x = vertcat(x,ones(1,size(x,2)));
x_ = vertcat(x_,ones(1,size(x_,2)));

% T = getT(x);
% T_ = getT(x_);
% 
% x = T*x;
% x_ = T_*x_;

a_ = x(:,1); b_ = x(:,2); c_ = x(:,3); d_ = x(:,4);
a = x_(:,1); b = x_(:,2); c = x_(:,3); d = x_(:,4);


A = [-a(1) -a(2)  -1    0     0    0  a(1)*a_(1)  a(2)*a_(1)  a_(1)
      0      0     0 -a(1) -a(2)  -1  a(1)*a_(2)  a(2)*a_(2)  a_(2)
       
    -b(1) -b(2)  -1     0     0    0  b(1)*b_(1)  b(2)*b_(1)  b_(1)
      0      0    0  -b(1) -b(2)  -1  b(1)*b_(2)  b(2)*b_(2)  b_(2)
       
    -c(1) -c(2)  -1    0     0     0  c(1)*c_(1)  c(2)*c_(1)  c_(1)
      0      0    0  -c(1) -c(2)  -1  c(1)*c_(2)  c(2)*c_(2)  c_(2)
       
    -d(1) -d(2)  -1    0     0     0  d(1)*d_(1)  d(2)*d_(1)  d_(1)
      0      0    0  -d(1) -d(2)  -1  d(1)*d_(2)  d(2)*d_(2)  d_(2)];

% [~, ~, v] = svd(A);
% Hhat= v(:,end);
% Hhat = reshape(Hhat,3,3)';
% [u, d, v] = svd(Hhat);
% d(3,3)=0;
% H = u*d*v';
% H = H/H(3,3);
     
h = null(A);
h = h/h(9);
H = [h(1), h(2), h(3);
     h(4), h(5), h(6);
     h(7), h(8), h(9);];

% H = T'*H*T_;
% 
% H = H./H(3,3);

end
