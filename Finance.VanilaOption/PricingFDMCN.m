function Price = PricingFDMCN(S0, K, RiskFree, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, PlotFlag, NumFig)
Smax = 5 * S0;
Tmax = DayCount / BasedYears;

Strikes = linspace(0, Smax, NumOfSGrid);
Tau = linspace(0, Tmax, NumOfTGrid);

dt = Tau(2) - Tau(1);
dS = Strikes(2) - Strikes(1);

payoff = zeros(NumOfSGrid,NumOfTGrid);

if strcmp(Type, 'Call')
    payoff(:,end) = max(Strikes - K, 0);
    payoff(end,:) = (Strikes(end) - K) * exp((RiskFree-Dividend) * Tau);
    payoff(1,:) = 0;
elseif strcmp(Type, 'Put')
    payoff(:,end) = max(K - Strikes, 0);
    payoff(end,:) = 0;
    payoff(1,:) = (K - Strikes(end)) * exp((RiskFree-Dividend) * Tau);
end

a = 0.25*dt*( -(RiskFree - Dividend)/dS + Volatility.^2*Strikes./dS.^2).*Strikes;
b = -0.5*dt*(Volatility^2*(Strikes.^2)/(dS.^2) + (RiskFree - Dividend));
c = 0.25*dt*((RiskFree - Dividend)/dS + Volatility.^2*Strikes./dS.^2).*Strikes;

coeff = -diag(a(3:NumOfSGrid),-1) + diag(1 - b(2:NumOfSGrid)) - diag(c(2:NumOfSGrid-1),1);
[L, U] = lu(coeff);
D = diag(a(3:NumOfSGrid),-1) + diag(1 + b(2:NumOfSGrid)) + diag(c(2:NumOfSGrid-1),1);
Boundary = zeros(NumOfSGrid - 1,1);
for j = NumOfTGrid - 1 : -1 : 1
    Boundary(1) = a(2) * (payoff(1,j) + payoff(1,j+1));
    Boundary(end) = c(end) * (payoff(end,j) + payoff(end,j+1));
    payoff(2:NumOfSGrid, j) = U \ (L \ (D * payoff(2:NumOfSGrid, j + 1) + Boundary));
end
if PlotFlag == 1
    figure(NumFig)
    [S, T] = meshgrid(Strikes,Tau);
    surf(T, S,payoff');
    title('BS 1D - Implicit FDM');
    xlabel('Tau');ylabel('Strikes');zlabel('Payoff');
    ylim([10, Smax/2]);zlim([0 max(max(payoff))]);
end
Price = interp1(Strikes, payoff(:,1), S0);