%% 

clear all; close all; clc; rng('default')

% Generation of n random samples on the plane
n=10; % Number of samples
x=zeros(2,n);
x(1,:)=2*rand(1,n)-1; % x are n random samples from [-1,1]
x(2,:)=sin(x(1,:))+0.1*randn(1,n); % y = sin(x) + little noises

% Standardization
mu=mean(x,2);
x1=x-repmat(mu,1,n);
si=(1/n)*(x1*x1');
si=diag(si); 
for i=1:2
    x1(i,:)=x1(i,:)/si(i);
end

figure
angle=pi*(0:0.001:1);
score=zeros(size(angle));
for k=1:length(angle);
    th=angle(k);
    
    % Projection to the straight line y = tan(theta) * x
    normal=[-tan(th); 1];
    unit_normal=normal./norm(normal);
    Proj1=x1;
    for j=1:n
        Proj1(:,j)=x1(:,j)-sum(x1(:,j).*unit_normal)*unit_normal;
    end
    xp1=-4:0.1:4;
    yp1=tan(th)*xp1;
    score(k)=(1/n)*sum(diag(Proj1*Proj1'));
    
    % De-Standardization
    for i=1:2
        Proj1(i,:)=si(i)*Proj1(i,:);
    end
    Proj=Proj1+repmat(mu,1,n);
	xp=si(1)*xp1+repmat(mu(1),1,length(xp1));
    yp=si(2)*yp1+repmat(mu(2),1,length(xp1)); 
    plot(x(1,:),x(2,:),'o',Proj(1,:),Proj(2,:),'or',xp,yp);
    axis([-2 2 -2 2])
    pause(0.01)

end

figure
[~,idx_angle]=max(score);
for k=1:1;
    th=angle(idx_angle);
    
    % Projection to the straight line y = tan(theta) * x
    normal=[-tan(th); 1];
    unit_normal=normal./norm(normal);
    Proj1=x1;
    for j=1:n
        Proj1(:,j)=x1(:,j)-sum(x1(:,j).*unit_normal)*unit_normal;
    end
    xp1=-4:0.1:4;
    yp1=tan(th)*xp1;
    score(k)=(1/n)*sum(diag(Proj1*Proj1'));
    
    % De-Standardization
    for i=1:2
        Proj1(i,:)=si(i)*Proj1(i,:);
    end
    Proj=Proj1+repmat(mu,1,n);
	xp=si(1)*xp1+repmat(mu(1),1,length(xp1));
    yp=si(2)*yp1+repmat(mu(2),1,length(xp1)); 
    plot(x(1,:),x(2,:),'o',Proj(1,:),Proj(2,:),'or',xp,yp);
    axis([-2 2 -2 2])
    pause(0.01)

end

%%

% Step 1. Normalization
x=x'; % nx2
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
plot(x(:,1),x(:,2),'o',x_pca(:,1),x_pca(:,2),'o-r')
axis([-2 2 -2 2])

