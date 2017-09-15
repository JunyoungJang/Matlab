function [J grad] = cost(th,A,y)

J = (-1)*(y'* log(logsig(A*th))+(1-y')*log(1-logsig(A*th)));
grad = A'*(logsig(A*th)-y);

end

