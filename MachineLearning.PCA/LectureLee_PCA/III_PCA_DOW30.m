%% Initial cleaning

clear all; close all; clc; rng('default');  

%% Data loading

Daily_Adjust_Close=xlsread('DOW30.xlsx');
%Daily_Adjust_Close=Daily_Adjust_Close(1:10,:);
Daily_Adjust_Close=Data_Cleaning_Initial(Daily_Adjust_Close);
Daily_Adjust_Close_Benchmark=Data_Cleaning_Benchmark(Daily_Adjust_Close);
Daily_Return_Benchmark=Return_Computation_Daily(Daily_Adjust_Close_Benchmark);
x=Daily_Return_Benchmark;
start=1;
x=x(1+(start-1):12*21+(start-1),:);

%% PCA - k=3 components

% Step 1. Normalization
[z,mu,si]=Centering_and_Normalization(x);
[n,N_Assets]=size(z);

% Step 2. svd
k=3;
[U3,S3,V3]=svd(z); % [U,S,V] = svd(X) - X = U*S*V'
U4=U3(:,1:k); S4=S3(1:k,1:k); V4=V3(:,1:k);
z_pca=U4*S4*V4';
% when k=30, check diagonals of below Sigma_temp_check are all 1 
% Sigma_temp_check=(1/n)*((U4*S4*V4')'*(U4*S4*V4'));

% Step 3. De-Normalization
x_pca=bsxfun(@times,z_pca,si);
x_pca=bsxfun(@plus,x_pca,mu);

figure
subplot(3,3,1); plot(x(:,1),'-'); hold on; plot(x_pca(:,1),'-r')
subplot(3,3,2); plot(x(:,2),'-'); hold on; plot(x_pca(:,2),'-r')
subplot(3,3,3); plot(x(:,3),'-'); hold on; plot(x_pca(:,3),'-r')
subplot(3,3,4); plot(x(:,4),'-'); hold on; plot(x_pca(:,4),'-r')
subplot(3,3,5); plot(x(:,5),'-'); hold on; plot(x_pca(:,5),'-r')
subplot(3,3,6); plot(x(:,6),'-'); hold on; plot(x_pca(:,6),'-r')
subplot(3,3,7); plot(x(:,7),'-'); hold on; plot(x_pca(:,7),'-r')
subplot(3,3,8); plot(x(:,8),'-'); hold on; plot(x_pca(:,8),'-r')
subplot(3,3,9); plot(x(:,30),'-'); hold on; plot(x_pca(:,30),'-r')

s=cumprod(1+x);
s=[ones(1,N_Assets);s];
s_pca=cumprod(1+x_pca);
s_pca=[ones(1,N_Assets);s_pca];

figure
subplot(3,3,1); plot(s(:,1),'-'); hold on; plot(s_pca(:,1),'-r')
subplot(3,3,2); plot(s(:,2),'-'); hold on; plot(s_pca(:,2),'-r')
subplot(3,3,3); plot(s(:,3),'-'); hold on; plot(s_pca(:,3),'-r')
subplot(3,3,4); plot(s(:,4),'-'); hold on; plot(s_pca(:,4),'-r')
subplot(3,3,5); plot(s(:,5),'-'); hold on; plot(s_pca(:,5),'-r')
subplot(3,3,6); plot(s(:,6),'-'); hold on; plot(s_pca(:,6),'-r')
subplot(3,3,7); plot(s(:,7),'-'); hold on; plot(s_pca(:,7),'-r')
subplot(3,3,8); plot(s(:,8),'-'); hold on; plot(s_pca(:,8),'-r')
subplot(3,3,9); plot(s(:,30),'-'); hold on; plot(s_pca(:,30),'-r')

%% Decomposition of correlation matrix using PCA

figure
[U3,S3,V3]=svd(z); % [U,S,V] = svd(X) - X = U*S*V'
Sigma_temp2=zeros(N_Assets,N_Assets);
for k=1:7;
    U4=U3(:,1:k); S4=S3(1:k,1:k); V4=V3(:,1:k);
    Sigma_temp=(1/n)*(V4*S4^2*V4'); % Sigma_temp=(1/n)*(U4*S4*V4')'*(U4*S4*V4');
    [I,J]=meshgrid(1:N_Assets,1:N_Assets);
    subplot(2,7,k); contour(I,J,Sigma_temp-Sigma_temp2); % contour(I,J,Sigma_temp-Sigma_temp2,'ShowText','on');  
    subplot(2,7,k+7); mesh(I,J,Sigma_temp-Sigma_temp2); axis([1 30 1 30 0 1])
%     if k==1
%         subplot(1,2,1); contourf(I,J,Sigma_temp-Sigma_temp2); 
%         subplot(1,2,2); mesh(I,J,Sigma_temp-Sigma_temp2); axis([1 30 1 30 0 1])
%     end
    Sigma_temp2=Sigma_temp;
end