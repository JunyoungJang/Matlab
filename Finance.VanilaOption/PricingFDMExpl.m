function Price = PricingFDMExpl(S0, K, RiskFree, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, PlotFlag, NumFig)
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

a = 0.5 * dt * (Volatility^2 .* Strikes/dS.^2 - (RiskFree - Dividend)/dS).* Strikes;
b = 1 - dt * (Volatility^2 .* Strikes.^2/dS.^2 + (RiskFree - Dividend));
c = 0.5 * dt * (Volatility^2 .* Strikes/dS.^2 + (RiskFree - Dividend)/dS).* Strikes;

for j=NumOfTGrid - 1 : -1 : 1
    for i=2:NumOfSGrid - 1
        payoff(i,j) = a(i)*payoff(i-1,j+1) + b(i)*payoff(i,j+1) + c(i)*payoff(i+1,j+1);
    end
end
if PlotFlag == 1
    figure(NumFig);
    [S, T] = meshgrid(Strikes,Tau);
    surf(T, S,payoff');
    title('BS 1D - Explicit FDM');
    xlabel('Tau');ylabel('Strikes');zlabel('Payoff');
    ylim([10, Smax/2]);zlim([0 max(max(payoff))]);
end
Price = interp1(Strikes, payoff(:,1), S0);

