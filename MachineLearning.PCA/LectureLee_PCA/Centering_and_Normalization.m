function [z,mu,sigma] = Centering_and_Normalization(x)
% x     - number of data x number of features
% z     - number of data x number of features
% mu    - 1              x number of features
% sigma - 1              x number of features 

[n,~]=size(x);

mu=mean(x);
Sigma=cov(x,1);
sigma=sqrt(diag(Sigma)');

% zc=bsxfun(@minus,x,mu);
% z=bsxfun(@rdivide,zc,sigma);
zc=x-repmat(mu,n,1);
z=zc./repmat(sigma,n,1);

end

