clear all,clc, close all
z=@(x,y) x+y*i;
[X Y]=meshgrid(-5:0.01:5);
Z=z(X,Y);


%% Taylor - 2 order
p=abs(1+Z+(Z.^2)/2);%p(x)
figure(1);
subplot(1,3,1)
surfc(X,Y,p, 'EdgeColor', 'none');title('3D')
alpha(0.35);
subplot(1,3,2);contour(X,Y,p,[1 1],'k','LineWidth',1);grid on;title('Boundary');
A=zeros(length(p));
%To find stablity region
for i1=1:length(p)
    for i2=1:length(p)
        if p(i1,i2)<=1
            A(i1,i2)=p(i1,i2);
        end
    end
end
subplot(1,3,3);hold on;surf(X,Y,A,'EdgeColor', 'none');title('Stable');colorbar



%% Taylor - 4 order
clear p A;figure(2)
p=abs(1+Z+Z.^2/2+Z.^3/6+Z.^4/24); % p(x)
subplot(1,3,1)
surfc(X,Y,p, 'EdgeColor', 'none');title('3D')
alpha(0.35);
subplot(1,3,2);contour(X,Y,p,[1 1],'k','LineWidth',1);grid on;title('Boundary');
A=zeros(length(p));

%To find stablity region
for i1=1:length(p)
    for i2=1:length(p)
        if p(i1,i2)<=1
            A(i1,i2)=p(i1,i2);
        end
    end
end
subplot(1,3,3);hold on;surf(X,Y,A,'EdgeColor', 'none');title('Stable');colorbar


%% Adam-Bashforth
clear all
z=@(x) exp(x*i);
z=z(0:0.01:2*pi);


Z=(2*(z.^2-z))./(3*z-1);
figure(3);% Only draw
subplot(1,4,1);plot(Z);title('A-B 2 Step');grid on;
    
Z=(12*(z.^3-z.^2))./(23*z.^2-16*z+5); % Only draw
subplot(1,4,2);plot(Z);title('A-B 3 Step');grid on;

Z=(24*(z.^4-z.^3))./(55*z.^3-59*z.^2+37*z-9);% Only draw
subplot(1,4,3);plot(Z);title('A-B 4 Step');grid on;

Z=(720*(z.^5-z.^4))./(1901*z.^4-2774*z.^3+2616*z.^2-1274*z+251);% Only draw
subplot(1,4,4);plot(Z);title('A-B 5 Step');grid on;