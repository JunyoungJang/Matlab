%% PCA - eig

clear all; close all; clc;

load hald

% Step 1. Normalize to zero mean and, if needed, unit varinace
input=1;
switch input
    case 1
        x=ingredients(:,2:3); % 13x2
    case 2
        x=ingredients; 
end
[n,d_feature]=size(x);
[z,mu,si]=Centering_and_Normalization(x);
Sigma=cov(z,1);

% Step 2. Find top k=1 eigenvectors of Sigma. 
[V,la]=eig(Sigma)
V2=V(:,end);

X4_component=z*V2;
X4=(repmat(V2,1,n).*repmat(X4_component',d_feature,1)).*repmat(si',1,n)+repmat(mu',1,n);
X4=X4';

figure
plot(x(:,1),x(:,2),'o',X4(:,1),X4(:,2),'or')


%% PCA - svd

load hald

% Step 1. Normalization
input=1;
switch input
    case 1
        x=ingredients(:,2:3); % 13x2
    case 2
        x=ingredients; 
end
[z,mu,si]=Centering_and_Normalization(x);

% Step 2. svd
k=1;
[U,S,V]=svd(z); % [U,S,V] = svd(X) - X = U*S*V'
U_pca=U(:,1:k); S_pca=S(1:k,1:k); V_pca=V(:,1:k);
z_pca=U_pca*S_pca*V_pca';

% Step 3. De-Normalization
x_pca=bsxfun(@times,z_pca,si);
x_pca=bsxfun(@plus,x_pca,mu);

figure
plot(x(:,1),x(:,2),'o',x_pca(:,1),x_pca(:,2),'or')





