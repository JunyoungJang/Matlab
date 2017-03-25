function [root yval n]=bisection(fun,a,b,tol)
% Made David. J 
% Reference : Wiley, Introduction to numerical ordinary and partial
% diffeential eequations using matlab.
ya=feval(fun,a);yb=feval(fun,b);
if sign(ya)==sign(yb)
    error('function has sam sign at endpoints')
end
%If you don't input tol variance, for example like bisection(f,a,b).
if nargin<4
    tol=eps*max([abs(a) abs(b) 1]);
end

%Numerical Rootfinding START
an=a;bn=b;n=0;
while (b-a)/2^n >=tol
    xn=(an+bn)/2;yn=feval(fun,xn);n=n+1;
    if yn==0
        fprintf('Exact root\n');
        root=xn;ya=yn;
        return
    elseif sign(yn)==sign(ya)
        an=xn;ya=yn;
    else
        bn=xn;yb=yn;
    end
end

root=xn;yval=yn;
