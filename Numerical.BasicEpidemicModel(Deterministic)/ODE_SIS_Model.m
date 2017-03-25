function [t S I R]=ODE_SIS_Model(beta,gamma,time,N,infected)
y0=infected;
x0=N-y0;
z0=0;
dS=@(t,S,I,R) -beta*S*I+gamma*I;;
dI=@(t,S,I,R) beta*S*I-gamma*I;
dR=@(t,S,I,R) 0; 
[t S I R] = RungeKutta(dS,dI,dR,0,time,x0,y0,z0,0.01);
end