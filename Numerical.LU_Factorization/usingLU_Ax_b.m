function b=usingLU_Ax_b(A,b)
n=size(A,1);
for i=2:n
    % To Make LU
    A(i,i-1)=A(i,i-1)/A(i-1,i-1);
    A(i,i)=A(i,i)-A(i,i-1)*A(i-1,i);
    % To Solve Ly=b
    b(i)=b(i)-A(i,i-1)*b(i-1);
end
% To Solve Ux=y
 b(n)=b(n)/A(n,n);
for i=2:n
    b(n-i+1)=(b(n-i+1)-A(n-i+1,n-i+2)*b(n-i+2))/A(n-i+1,n-i+1);
end