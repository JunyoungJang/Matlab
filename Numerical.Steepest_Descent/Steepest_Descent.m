function [x1 relerr niter]= Steepest_Descent(A,b,tol)

relerr = inf;
niter = 1;

x0 = zeros( size(b) );

while relerr > tol
    v = b - A * x0 ;
    t = (v'*v) / (v'*A*v) ;
    x1 = x0 + t * v ;    
    relerr(niter) = norm(b-A*x1,inf);    
    x0 = x1;
    niter = niter+1;    
end

fprintf(1,'\n After %d iterations of Steepest Descent methods the relative error is %e.\n',niter,relerr);

