clear all
clc
%%  stability region for taylor series method of oder2
x=-5:0.01:1;
y=-3:0.01:3;
[X,Y]=meshgrid(x,y);
Z=X+i*Y;
p=abs(1+Z+(1/2)*Z.^2);
figure(1)
contour(x,y,p,[1,1],'r');
title(['Taylor serise method of oder2'],'fontsize',20)
grid on

%% contour로 시키기. 
% x=-5:0.01:1;
% y=-3:0.01:3;
% [X,Y]=meshgrid(x,y);
% Z=X+i*Y;
% p=abs(1+Z+(1/2)*Z.^2);
% v=linspace(0,1,200); % stability region check
% figure(1)
% contour(x,y,p,v);
% title(['Taylor serise method of oder2'],'fontsize',20)
% grid on
% h=colorbar('vert') 

%%  stability region for taylor series method of oder3
x=-5:0.01:1
y=-3:0.01:3;
[X,Y]=meshgrid(x,y);
Z=X+i*Y;
p=abs(1+Z+(1/2)*Z.^2+(1/6)*Z.^3);
%v=linspace(0,1,200);
%figure(2)
contour(x,y,p,[1,1],'r');
title(['Taylor serise method of oder3'],'fontsize',20)
grid on
%h=colorbar('vert')

%%  stability region for taylor series method of oder4
x=-5:0.01:1;
y=-3:0.01:3;
[X,Y]=meshgrid(x,y);
Z=X+i*Y;
p=abs(1+Z+(1/2)*Z.^2+(1/6)*Z.^3+(1/24)*Z.^4);
%v=linspace(0,1,200);
%figure(3)
contour(x,y,p,[1,1],'r');
title(['Taylor serise method of oder4'],'fontsize',20)
grid on
%h=colorbar('vert')