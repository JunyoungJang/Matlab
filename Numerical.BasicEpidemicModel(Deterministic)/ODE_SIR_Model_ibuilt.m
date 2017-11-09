function State=ODE_SIR_Model_ibuilt(t,y0,yp0,beta,gamma)
S = y0(1);
I = y0(2);
dS = yp0(1);
dI = yp0(2);

State= [dS + beta*S*I;
dI - beta*S*I + gamma*I];

end