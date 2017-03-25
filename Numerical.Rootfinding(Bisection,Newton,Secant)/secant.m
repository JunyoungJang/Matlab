function [root yval n]=secant(fun,a,b,tol)
% Made David. J 
% Reference : Wiley, Introduction to numerical ordinary and partial
% diffeential eequations using matlab.

if nargin<4
    tol=eps;
end

%Numerical Rootfinding START
n=-1;
xnew=b;
while abs(xnew-a)>tol
    n=n+1;
    b=xnew;
    ya=feval(fun,a);yb=feval(fun,b);
    xnew=b-yb*(b-a)/(yb-ya);
    a=b;
end
root=xnew;yval=feval(fun,root);n;