clear all
SIR_paraset
options = odeset('RelTol',1e-4,'AbsTol',[1e-6 1e-10], ...
   'Jacobian',{[],[1 0; 0 1]});
[t,y] = ode15i(@ODE_SIR_Model_ibuilt,0:1:100,[S0;I0],[0;0],options,beta,gamma)