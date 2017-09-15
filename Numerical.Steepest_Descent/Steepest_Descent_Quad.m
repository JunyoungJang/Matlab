function [x1,x_coord,y_coord] = Steepest_Descent_Quad(A,b,tol,maxiter)

relerr = inf;
niter = 1;

x0 = zeros( size(b) );
x_coord(1) = x0(1);
y_coord(1) = x0(2);    

while relerr > tol && niter < maxiter    
    v = b - A * x0 ;
    t = (v'*v) / (v'*A*v) ;
    x1 = x0 + t * v ;    
    relerr = norm(b-A*x1,inf);    
    x0 = x1;    
    niter = niter+1;    
    
    x_coord(niter) = x1(1);
    y_coord(niter) = x1(2);    
    
end

fprintf(1,'\n After %d iterations of Steepest Descent methods the relative error is %e.\n',niter,relerr);

