%% stability region for Adams-Bashforth 2 step method.
syms x
syms z
z=-1/2;
y=(1/2)*z+(-1-(2/3)*z)*x+x^2;
[x]=solve(y)
% k=abs(x)   %x들의 absolute value check할 때.

%% stability region for Adams-Bashforth 3 step method.
syms x
syms z
z=-0.1;
y=-(5/12)*z+((16/12)*z)*x+(-1-(23/12)*z)*x^2+x^3;
[x]=solve(y)

%% stability region for Adams-Bashforth 4 step method.
syms x
syms z
z=-0.25;
y=(9/24)*z-((37/24)*z)*x+(59/24)*z*x^2+(-1-(55/24)*z)*x^3+x^4;
[x]=solve(y)

%% stability region for Adams-Moulton 2 step method.
syms x
syms z
z=-1;
y=(1/12)*z+(-1-(8/12)*z)*x+(1-(5/12)*z)*x^2;
[x]=solve(y)

%% stability region for Adams-Moulton 3 step method.
syms x
syms z
z=-1;
y=-(1/24)*z+((5/24)*z)*x+(-1-(19/24)*z)*x^2+(1-(9/24)*z)*x^3;
[x]=solve(y)

%% stability region for Adams-Moulton 4 step method.
syms x
syms z
z=-1;
y=(19/720)*z-((106/720)*z)*x+(264/720)*z*x^2+(-1-(646/720)*z)*x^3+(1-(251/720)*z)*x^4;
[x]=solve(y)  


