clear all,clc,close all

% A=[1 1; 1 1]; b=[1 1]';
% tol = 10^(-4); maxiter=100;
% f = @(x,y) (x.^2+2*x.*y+y.^2+x+y);
%A=[1 4 ; 4 1];
%b=[1;1];
%f=@(x,y) x.^2+8*x.*y+y.^2+x+y;
% A=[1 1; 4 4]; b=[1 6]';
% tol = 10^(-4); maxiter=100;
% f = @(x,y) (x.^2+5*x.*y+4*y.^2+x+6*y);
 A=[3 2; 2 6]; b=[2 -8]';
% A=[2 0; 0 -2]; b=[1 1]';
% tol = 10^(-4); maxiter=100;
% f = @(x,y) (x.^2-y.^2+x+y);

%A=[5 2 ;2 1]; b=[1 1]';
tol = 10^(-5); maxiter=100;
%f = @(x,y) (5*x.^2+4*x.*y+y.^2+x+y);

[x1,x_coord,y_coord] = Steepest_Descent_Quad(A,b,tol,maxiter);
x1
figure;
[X,Y] = meshgrid(-10:.05:10,-10:.05:10);
f =@(X,Y) 3*X.^2+4*X.*Y+6*Y.^2-4*X+16*Y;
Z=f(X,Y);
surfc(X,Y,Z,'EdgeColor','None');
pause(2);

figure;
for i=1:20
    %M(i)=getframe;
    if i==1
        contour(X,Y,Z,[5 f(x_coord(1),y_coord(1))],'k');
        hold on;
       % pause(1);
    else
        contour(X,Y,Z,[f(x_coord(i-1),y_coord(i-1)) f(x_coord(i),y_coord(i))],'k');
        hold on;
        %pause(1);
    end       
    figure(2);hold on
    plot(x_coord(i:i+1),y_coord(i:i+1),'r','LineWidth',2);
    hold on
   % pause(1);
end