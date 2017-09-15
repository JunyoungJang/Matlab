%% Logistic regression as a binary classifier
% Caution - labels are either 0 or 1

clear all; close all; clc; rng('default')

figure % figure 1

% generate data
n=60; % number of training set
m=floor(n/2); % number of negative set 
x=zeros(n,2); 
x(1:(m/3),:)=randn(m/3,2)+repmat([5 5],m/3,1); % features of negative set
x((m/3)+1:(2*m/3),:)=randn(m/3,2)+repmat([-5 -5],m/3,1); % features of negative set
x((2*m/3)+1:m,:)=randn(m/3,2)+repmat([-5 5],m/3,1); % features of negative set
x(m+1:n,:)=randn(n-m,2)+repmat([5 -5],n-m,1); % features of positive set
y=zeros(n,1); % labels of negative set   
y(m+1:n,1)=ones(n-m,1); % labels of positive set 
A=[ones(n,1) x]; % design matrix
plot(x(1:m,1),x(1:m,2),'o',x(m+1:n,1),x(m+1:n,2),'or'); hold on; grid on
x_min=min(x);
x_max=max(x);
axis([x_min(1) x_max(1) x_min(2) x_max(2)])

% optimization
N_Features=size(A,2); % number of features including 1
initial_th=zeros(N_Features,1); % initial theta
options=optimset('GradObj','on','MaxIter',1000);
final_th=fmincg(@(th)cost(th,A,y),initial_th,options);

% decison boundary
c=final_th 
x1p=[x_min(1) x_max(1)];
x2p=(-c(1)-c(2)*x1p)./c(3);
plot(x1p,x2p,'-b'); hold on
pause(1)

%% Optimal margin classifier - Quadratic program formulation
% Caution - labels are either -1 or 1

% min \f{1}{2}x'*H*x+f'*x
H=diag([0 1 1]); 
f=[0; 0; 0];
% subject to A*x \le b
A=[ones(n,1) x]; % design matrix
y_plus_minus=y;
y_plus_minus(y==0)=-1; % Caution - labels are either -1 or 1
B=repmat(y_plus_minus,[1 3]);
A_ineq=-1*repmat(y_plus_minus,[1 3]).*A;
b_ineq=-1*ones(n,1);
% quadratic programing
final_th2=quadprog(H,f,A_ineq,b_ineq);

% decison boundary
c2=final_th2 
x1p=[x_min(1) x_max(1)];
x2p=(-c2(1)-c2(2)*x1p)./c2(3);
plot(x1p,x2p,'-r'); hold on
pause(1)

% report distance of positive and negative inputs from decison boundary
d=(y_plus_minus.*(A*final_th2))/sqrt(final_th2(2)^2+final_th2(3)^2);
d1=min(abs(d(1:m))) % distance of negative inputs from decison boundary 
d2=min(abs(d(m+1:end))) % distance of positive inputs from decison boundary

%% Optimal margin classifier - dual formulation
% Caution - labels are either -1 or 1

% min \f{1}{2}x'*H*x+f'*x
A=[ones(n,1) x]; % design matrix
A_temp=A(:,2:end);
Part_1=A_temp*A_temp';
y_plus_minus=y;
y_plus_minus(y==0)=-1; % Caution - labels are either -1 or 1
Part_2=y_plus_minus*y_plus_minus';
H=Part_1.*Part_2; %+10^(-10)*eye(n); % regularization +e-10*eye(n) 
f=-ones(1,n);
% subject to A*x \le b
A_ineq=(-1)*eye(n);
b_ineq=zeros(n,1);
% subject to A_eq*x = b_eq
A_eq=y_plus_minus';
b_eq=0;
% options
options=optimset('MaxIter',2000);
% quadratic programing - dual
[al,~,exitflag]=quadprog(H,f,A_ineq,b_ineq,A_eq,b_eq,[],[],[],options);
% back to original
final_th3=sum(repmat(al,[1 2]).*repmat(y_plus_minus,[1 2]).*x)';
Part_1=max(x(1:m,:)*final_th3);
Part_2=min(x(m+1:end,:)*final_th3);
b_star=-(Part_1+Part_2)/2; 
final_th3=[b_star;final_th3];

% decison boundary
c3=final_th3 
x1p=[x_min(1) x_max(1)];
x2p=(-c3(1)-c3(2)*x1p)./c3(3);
plot(x1p,x2p,'-g'); hold on
pause(1)

% support vector
support_vector_indicator=(al>10^(-6));
support_vector=A_temp(support_vector_indicator,:)
support_al=al(support_vector_indicator,:);
support_y_plus_minus=y_plus_minus(support_vector_indicator,:);
plot(support_vector(:,1),support_vector(:,2),'*g'); hold on
pause(1)

% report distance of positive and negative inputs from decison boundary
d_dual=(y_plus_minus.*(A*final_th3))/sqrt(final_th3(2)^2+final_th3(3)^2);
d3=min(abs(d_dual(1:m))) % distance of negative inputs from decison boundary 
d4=min(abs(d_dual(m+1:end))) % distance of positive inputs from decison boundary

%% decison boundary via support vector

xmin=min(x);
xmax=max(x);
x1p=xmin(1):0.1:xmax(1);
x2p=xmin(2):0.1:xmax(2);
[X1P X2P]=meshgrid_Lee(x1p,x2p);
X=[X1P(:) X2P(:)];
sign_decison_boundary=sum((repmat(support_al.*support_y_plus_minus,[1 2]).*support_vector)*X')+final_th3(1);
sign_decison_boundary=sign_decison_boundary';
classification=sign(sign_decison_boundary);

%% class 1

plot(X1P(classification==1),X2P(classification==1),'.r','MarkerSize',6);
pause(1)

%% class -1

plot(X1P(classification==-1),X2P(classification==-1),'.','MarkerSize',6);
pause(1)

%% Optimal margin classifier - kernel formulation
% Caution - labels are either -1 or 1

figure % figure 2

plot(x(1:m,1),x(1:m,2),'o',x(m+1:n,1),x(m+1:n,2),'or'); hold on; grid on
x_min=min(x);
x_max=max(x);
axis([x_min(1) x_max(1) x_min(2) x_max(2)])
pause(1)

% min \f{1}{2}x'*H*x+f'*x
A=[ones(n,1) x]; % design matrix
A_temp=A(:,2:end);
% Kernel choice -----------------------------------------------------------
% Kernel = @(x_i,x_k) x_i*x_k'; % Usual kernel  
% c=0; d=6; Kernel = @(x_i,x_k) (c+x_i*x_k')^d; % Polynomial kernel
sigma=10; Kernel = @(x_i,x_k) exp(-sum((x_i-x_k).^2)/(2*sigma^2)); % Gaussian kernel  
% a=1; b=1; Kernel = @(x_i,x_k) tanh(a*x_i*x_k'+b); % Sigmoid kernel
% Kernel choice -----------------------------------------------------------
%Part_1=A_temp*A_temp'; % If usual kernel used, use this instead of below 6 lines
Part_1=zeros(n,n);
for i=1:n
    for j=1:n
        Part_1(i,j)=Kernel(A_temp(i,:),A_temp(j,:));
    end
end
y_plus_minus=y;
y_plus_minus(y==0)=-1; % Caution - labels are either -1 or 1
Part_2=y_plus_minus*y_plus_minus';
H=Part_1.*Part_2; %+10^(-10)*eye(n); % regularization +e-10*eye(n) 
f=-ones(1,n);
% subject to A*x \le b
A_ineq=(-1)*eye(n);
b_ineq=zeros(n,1);
% subject to A_eq*x = b_eq
A_eq=y_plus_minus';
b_eq=0;
% options
options=optimset('MaxIter',2000);
% quadratic programing - dual
[al,~,exitflag]=quadprog(H,f,A_ineq,b_ineq,A_eq,b_eq,[],[],[],options);
% back to original
support_vector_indicator=(al>10^(-6));
support_vector=A_temp(support_vector_indicator,:)
support_al=al(support_vector_indicator,:);
support_y_plus_minus=y_plus_minus(support_vector_indicator,:);
plot(support_vector(:,1),support_vector(:,2),'*g'); hold on
pause(1)
b_star=0;
for i=1:length(support_al)
    temp=0;
    for j=1:length(support_al)
        temp=temp+support_al(j)*support_y_plus_minus(j)*Kernel(support_vector(j,:),support_vector(i,:));
    end
    b_star=b_star+(1/support_y_plus_minus(i))-temp;
end
b_star=b_star/length(support_al);

%% decison boundary via support vector

xmin=min(x);
xmax=max(x);
x1p=xmin(1):0.1:xmax(1);
x2p=xmin(2):0.1:xmax(2);
[X1P X2P]=meshgrid_Lee(x1p,x2p);
X=[X1P(:) X2P(:)];
sign_decison_boundary=zeros(length(X),1);
for i=1:length(sign_decison_boundary)
    x_temp=X(i,:);
    temp=0;
    for j=1:length(support_al)
        temp=temp+support_al(j)*support_y_plus_minus(j)*Kernel(support_vector(j,:),x_temp);
    end
    sign_decison_boundary(i)=temp+b_star;
end
classification=sign(sign_decison_boundary);

%% class 1

plot(X1P(classification==1),X2P(classification==1),'.r','MarkerSize',6);
pause(1)

%% class -1

plot(X1P(classification==-1),X2P(classification==-1),'.','MarkerSize',6);
title('Optimal margin classifier - kernel formulation')
pause(1)

%% SVM
% Caution - labels are either -1 or 1

figure % figure 3

plot(x(1:m,1),x(1:m,2),'o',x(m+1:n,1),x(m+1:n,2),'or'); hold on; grid on
x_min=min(x);
x_max=max(x);
axis([x_min(1) x_max(1) x_min(2) x_max(2)])
pause(1)

% min \f{1}{2}x'*H*x+f'*x
A=[ones(n,1) x]; % design matrix
A_temp=A(:,2:end);
% Kernel choice -----------------------------------------------------------
% Kernel = @(x_i,x_k) x_i*x_k'; % Usual kernel  
% c=0; d=6; Kernel = @(x_i,x_k) (c+x_i*x_k')^d; % Polynomial kernel
sigma=10; Kernel = @(x_i,x_k) exp(-sum((x_i-x_k).^2)/(2*sigma^2)); % Gaussian kernel  
% a=1; b=1; Kernel = @(x_i,x_k) tanh(a*x_i*x_k'+b); % Sigmoid kernel
% Kernel choice -----------------------------------------------------------
%Part_1=A_temp*A_temp'; % If usual kernel used, use this instead of below 6 lines
Part_1=zeros(n,n);
for i=1:n
    for j=1:n
        Part_1(i,j)=Kernel(A_temp(i,:),A_temp(j,:));
    end
end
y_plus_minus=y;
y_plus_minus(y==0)=-1; % Caution - labels are either -1 or 1
Part_2=y_plus_minus*y_plus_minus';
H=Part_1.*Part_2; %+10^(-10)*eye(n); % regularization +e-10*eye(n) 
H=[H zeros(n,n); zeros(n,n) zeros(n,n)];
f=-ones(1,n);
f=[f zeros(1,n)];
Constant=0.1;
% subject to A*x \le b
% (-1)*[eye(n,n) zeros(n,n)]	zeros(n,1)          % al_i \ge 0
% [eye(n,n) zeros(n,n)]       Constant*ones(n,1)	% al_i \le Constant
A_ineq=[(-1)*[eye(n,n) zeros(n,n)]; [eye(n,n) zeros(n,n)]];
b_ineq=[zeros(n,1); Constant*ones(n,1)];
% subject to A_eq*x = b_eq
% [y_plus_minus' zeros(1,n)]	0                   % (12.11) of Elements of Statistical Learning
% [eye(n,n) eye(n,n)]         Constant*ones(n,1)	% (12.12) of Elements of Statistical Learning
A_eq=[[y_plus_minus' zeros(1,n)]; [eye(n,n) eye(n,n)]];
b_eq=[0; Constant*ones(n,1)];
% options
options=optimset('MaxIter',2000);
% quadratic programing - dual
[al_temp,~,exitflag]=quadprog(H,f,A_ineq,b_ineq,A_eq,b_eq,[],[],[],options);
% back to original
al=al_temp(1:n,:);
mu=al_temp(n+1:end,:);
%support_vector_indicator=(al>10^(-6)&al<Constant-10^(-6));
support_vector_indicator=(al>10^(-6));
support_vector=A_temp(support_vector_indicator,:)
support_al=al(support_vector_indicator,:);
support_y_plus_minus=y_plus_minus(support_vector_indicator,:);
plot(support_vector(:,1),support_vector(:,2),'*g'); hold on
pause(1)
b_star=0;
for i=1:length(support_al)
    temp=0;
    for j=1:length(support_al)
        temp=temp+support_al(j)*support_y_plus_minus(j)*Kernel(support_vector(j,:),support_vector(i,:));
    end
    b_star=b_star+(1/support_y_plus_minus(i))-temp;
end
b_star=b_star/length(support_al);

%% decison boundary via support vector

xmin=min(x);
xmax=max(x);
x1p=xmin(1):0.1:xmax(1);
x2p=xmin(2):0.1:xmax(2);
[X1P X2P]=meshgrid_Lee(x1p,x2p);
X=[X1P(:) X2P(:)];
sign_decison_boundary=zeros(length(X),1);
for i=1:length(sign_decison_boundary)
    x_temp=X(i,:);
    temp=0;
    for j=1:length(support_al)
        temp=temp+support_al(j)*support_y_plus_minus(j)*Kernel(support_vector(j,:),x_temp);
    end
    sign_decison_boundary(i)=temp+b_star;
end
classification=sign(sign_decison_boundary);

%% class 1

plot(X1P(classification==1),X2P(classification==1),'.r','MarkerSize',6);
pause(1)

%% class -1

plot(X1P(classification==-1),X2P(classification==-1),'.','MarkerSize',6);
title('SVM with both al and mu')
pause(1)

%% SVM with al only (without mu)
% Caution - labels are either -1 or 1

figure % figure 4

plot(x(1:m,1),x(1:m,2),'o',x(m+1:n,1),x(m+1:n,2),'or'); hold on; grid on
x_min=min(x);
x_max=max(x);
axis([x_min(1) x_max(1) x_min(2) x_max(2)])
pause(1)

% min \f{1}{2}x'*H*x+f'*x
A=[ones(n,1) x]; % design matrix
A_temp=A(:,2:end);
% Kernel choice -----------------------------------------------------------
% Kernel = @(x_i,x_k) x_i*x_k'; % Usual kernel  
% c=0; d=6; Kernel = @(x_i,x_k) (c+x_i*x_k')^d; % Polynomial kernel
sigma=10; Kernel = @(x_i,x_k) exp(-sum((x_i-x_k).^2)/(2*sigma^2)); % Gaussian kernel  
% a=1; b=1; Kernel = @(x_i,x_k) tanh(a*x_i*x_k'+b); % Sigmoid kernel
% Kernel choice -----------------------------------------------------------
%Part_1=A_temp*A_temp'; % If usual kernel used, use this instead of below 6 lines
Part_1=zeros(n,n);
for i=1:n
    for j=1:n
        Part_1(i,j)=Kernel(A_temp(i,:),A_temp(j,:));
    end
end
y_plus_minus=y;
y_plus_minus(y==0)=-1; % Caution - labels are either -1 or 1
Part_2=y_plus_minus*y_plus_minus';
H=Part_1.*Part_2; %+10^(-10)*eye(n); % regularization +e-10*eye(n) 
f=-ones(1,n);
Constant=0.1;
% subject to A*x \le b
% (-1)*[eye(n,n)]	zeros(n,1)          % al_i \ge 0
% [eye(n,n)]        Constant*ones(n,1)	% al_i \le Constant
A_ineq=[(-1)*eye(n,n); eye(n,n)];
b_ineq=[zeros(n,1); Constant*ones(n,1)];
% subject to A_eq*x = b_eq
% [y_plus_minus']	0                   % (12.11) of Elements of Statistical Learning
A_eq=y_plus_minus';
b_eq=0;
% options
options=optimset('MaxIter',2000);
% quadratic programing - dual
[al_temp,~,exitflag]=quadprog(H,f,A_ineq,b_ineq,A_eq,b_eq,[],[],[],options);
% back to original
al=al_temp(1:n,:);
mu=al_temp(n+1:end,:);
%support_vector_indicator=(al>10^(-6)&al<Constant-10^(-6));
support_vector_indicator=(al>10^(-6));
support_vector=A_temp(support_vector_indicator,:)
support_al=al(support_vector_indicator,:);
support_y_plus_minus=y_plus_minus(support_vector_indicator,:);
plot(support_vector(:,1),support_vector(:,2),'*g'); hold on
pause(1)
b_star=0;
for i=1:length(support_al)
    temp=0;
    for j=1:length(support_al)
        temp=temp+support_al(j)*support_y_plus_minus(j)*Kernel(support_vector(j,:),support_vector(i,:));
    end
    b_star=b_star+(1/support_y_plus_minus(i))-temp;
end
b_star=b_star/length(support_al);

%% decison boundary via support vector

xmin=min(x);
xmax=max(x);
x1p=xmin(1):0.1:xmax(1);
x2p=xmin(2):0.1:xmax(2);
[X1P X2P]=meshgrid_Lee(x1p,x2p);
X=[X1P(:) X2P(:)];
sign_decison_boundary=zeros(length(X),1);
for i=1:length(sign_decison_boundary)
    x_temp=X(i,:);
    temp=0;
    for j=1:length(support_al)
        temp=temp+support_al(j)*support_y_plus_minus(j)*Kernel(support_vector(j,:),x_temp);
    end
    sign_decison_boundary(i)=temp+b_star;
end
classification=sign(sign_decison_boundary);

%% class 1

plot(X1P(classification==1),X2P(classification==1),'.r','MarkerSize',6);
pause(1)

%% class -1

plot(X1P(classification==-1),X2P(classification==-1),'.','MarkerSize',6);
title('SVM with al only')
pause(1)

%% Original data

figure % figure 5

plot(x(1:m,1),x(1:m,2),'o',x(m+1:n,1),x(m+1:n,2),'or'); hold on; grid on
x_min=min(x);
x_max=max(x);
axis([x_min(1) x_max(1) x_min(2) x_max(2)])
title('Original data')

