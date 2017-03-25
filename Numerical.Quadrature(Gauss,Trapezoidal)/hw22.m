clc, clear all, close all
tic
%matlabpool
f=@(x) cos(x).*log(x);int(1)=0;
exact=integral(@(x) cos(x).*log(x),0,4*pi);
parfor i=1:1.e7
    nu=Gquad2(f,0,4*pi,i,'C');
    if abs((exact-nu)/exact)<1.e-8
        fprintf('|||  2-1 Result   || iteration - %5d | value - %20.4f | error - |||\n',i,nu);
    end
end