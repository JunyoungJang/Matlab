function State=ODE_SIR_Model_built(t,y0,beta,gamma)
S = y0(1);
I = y0(2);

dS= -beta*S*I;
dI= beta*S*I-gamma*I;

State = [dS; dI];
end