%% Adams-Moulton 2 step
th=0:0.01:2*pi;
n=length(th);
for j=1:n
et(j)=cos(th(j))+i*sin(th(j));
z(j)=12*(et(j)-et(j).^2)/(1-8*et(j)-5*et(j).^2);
end
figure(1)
p=plot(z)
set(p,'LineWidth',2)
grid on
title(['stability region for Adams-Moulton 2 step'],'fontsize',20)
axis([-6.5 1.5 -4 4 ])
 
%% Adams-Moulton 3 step
th=0:0.01:2*pi;
n=length(th);
for j=1:n
et(j)=cos(th(j))+i*sin(th(j));
z(j)=24*(et(j).^2-et(j).^3)/(-9*et(j).^3-19*et(j).^2+5*et(j)-1);
end
figure(2)
p=plot(z)
set(p,'LineWidth',2)
grid on
title(['stability region for Adams-Moulton 3 step'],'fontsize',20)
axis([-6.5 1.5 -4 4 ])

%% Adams-Moulton 4 step
th=0:0.01:2*pi;
n=length(th);
for j=1:n
et(j)=cos(th(j))+i*sin(th(j));
z(j)=-720*(et(j).^4-et(j).^3)/(-251*et(j).^4-646*et(j).^3+264*et(j).^2-106*et(j)+19);
end
figure(3)
p=plot(z)
set(p,'LineWidth',2)
grid on
title(['stability region for Adams-Moulton 4 step'],'fontsize',20)
axis([-6.5 1.5 -4 4 ])
