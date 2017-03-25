%% Adams-bashforth 2 step
th=0:0.01:2*pi;
n=length(th);
for j=1:n
et(j)=cos(th(j))+i*sin(th(j));
z(j)=2*(et(j)-et(j).^2)/(1-3*et(j));
end 
figure(1)
p=plot(z); 
set(p,'LineWidth',2);
grid on
title(['stability region for Adams-bashforth 2 step'],'fontsize',20)
axis([-3 1 -2 2])
 
%% Adams-bashforth 3 step
th=0:0.01:2*pi;
n=length(th);
for j=1:n
et(j)=cos(th(j))+i*sin(th(j));
z(j)=-12*(et(j).^2-et(j).^3)/(23*et(j).^2-16*et(j)+5);
end
figure(2)
p=plot(z);
set(p,'LineWidth',2);
grid on
title(['stability region for Adams-bashforth 3 step'],'fontsize',20)
axis([-3 1 -2 2])

%% Adams-bashforth 4 step
th=0:0.01:2*pi;
n=length(th);
for j=1:n
et(j)=cos(th(j))+i*sin(th(j));
z(j)=-24*(et(j).^4-et(j).^3)/(-55*et(j).^3+59*et(j).^2-37*et(j)+9);
end
figure(3)
p=plot(z);
set(p,'LineWidth',2);
grid on
title(['stability region for Adams-bashforth 4 step'],'fontsize',20)
axis([-3 1 -2 2])
