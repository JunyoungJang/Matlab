function [root yval n]=newtonUsingfor(fun,dfun,x0,tol,nmax)
% Made David. J 
% Reference : Wiley, Introduction to numerical ordinary and partial
% diffeential eequations using matlab.

if nargin<4
    tol=eps;nmax=100;
end

%Numerical Rootfinding START
xn=x0;
for n=1:nmax
    yn=feval(fun,xn);ypn=feval(dfun,xn);
    if yn==0
        fprintf('Exact root found\n')
        root=xn;yval=0;
        return
    end
    if ypn==0
        error('Zero derivative encountered, Newton''s method failed, try changing x0');
    end
    xnew=xn-yn/ypn;
    if abs(xnew-xn)<tol
        fprintf('Newton''s Method has converged\n')
        root=xnew;yval=feval(fun,root);
        return
    elseif n==nmax
        fprintf('Maximum number of iterations reached\n')
        root=xnew;yval=feval(fun,root);
        return
    end
    xn=xnew;
end