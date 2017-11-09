clear all
SIR_paraset
[t,y] = ode45(@ODE_SIR_Model_built,0:1:100,[S0;I0],options,beta,gamma)