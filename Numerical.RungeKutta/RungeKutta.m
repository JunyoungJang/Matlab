function [t x y z] = RungeKutta(f,g,v,a,b,x0,y0,z0,h)
nmax = ceil((b-a)/h);
t=zeros(nmax,1); t(1) = a; 
x=zeros(nmax,1); x(1)= x0; 
y=zeros(nmax,1); y(1) = y0;
z=zeros(nmax,1); z(1) = z0;
for n=1:nmax
    t(n+1) = t(n) + h;
    k1     = f(t(n),x(n),y(n),z(n));
    l1     = g(t(n),x(n),y(n),z(n));
    v1     = v(t(n),x(n),y(n),z(n));
    k2     = f(t(n)+h/2,x(n)+h/2*k1,y(n)+h/2*l1,z(n)+h/2*v1);
    l2     = g(t(n)+h/2,x(n)+h/2*k1,y(n)+h/2*l1,z(n)+h/2*v1); 
    v2     = v(t(n)+h/2,x(n)+h/2*k1,y(n)+h/2*l1,z(n)+h/2*v1); 
    k3     = f(t(n)+h/2,x(n)+h/2*k2,y(n)+h/2*l2,z(n)+h/2*v2);
    l3     = g(t(n)+h/2,x(n)+h/2*k2,y(n)+h/2*l2,z(n)+h/2*v2);
    v3     = v(t(n)+h/2,x(n)+h/2*k2,y(n)+h/2*l2,z(n)+h/2*v2);
    k4     = f(t(n+1),  x(n)+h*k3,  y(n)+h*l3,z(n)+h*v3);
    l4     = g(t(n+1),  x(n)+h*k3,  y(n)+h*l3,z(n)+h*v3);
    v4     = v(t(n+1),  x(n)+h*k3,  y(n)+h*l3,z(n)+h*v3);
    x(n+1) = x(n) + h/6*(k1+ 2*k2 +2*k3 +k4);
    y(n+1) = y(n) + h/6*(l1+ 2*l2 +2*l3 +l4);
    z(n+1) = z(n) + h/6*(v1+ 2*v2 +2*v3 +v4);
end
end