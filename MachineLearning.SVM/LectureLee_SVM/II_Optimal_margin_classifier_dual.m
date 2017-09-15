%% Logistic regression as a binary classifier
% Caution - labels are either 0 or 1

clear all; close all; clc; rng('default')

figure % figure 1

% generate data
n=20; % number of training set
m=floor(n/2); % number of negative set 
x=zeros(n,2); 
x(1:m,:)=randn(m,2)+repmat([-5 5],n-m,1); % features of negative set 
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
return
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

