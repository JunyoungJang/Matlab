function [root yval n]=newton(fun,dfun,x0,tol,nmax)
% Made David. J 
% Reference : Wiley, Introduction to numerical ordinary and partial
% diffeential eequations using matlab.

if nargin<4
    tol=eps;nmax=100;
end

%Numerical Rootfinding START
xn=x0;
xnew=x0+1;
n=-1;
while abs(xnew-xn)>tol
    n=n+1;
    xn=xnew;
    if n==100
        fprintf('You can suspect this cycling Newton''s Method');
    end
    yn=feval(fun,xn);ypn=feval(dfun,xn);
    xnew=xn-yn/ypn;
end
root=xnew;yval=feval(fun,root);n;