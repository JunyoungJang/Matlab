function result=usingLU_Ax_b_vector(a,b,c,result)
    n=size(result,1);
for k=2:n
    c(k)=c(k)/a(k-1);
    a(k)=a(k)-c(k)*b(k-1);
    result(k)=result(k)-c(k)*result(k-1);
end
   result(n)=result(n) /a(n);
for j=n-1:-1:1
   result(j)=(result(j)-b(j)*result(j+1))/a(j);
end


