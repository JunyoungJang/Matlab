function Price=PricingMC_Antitheric(Spot, Strike, RiskFree, Dividend, Volatility, NumOfSimulation, BasedYears, DayCount, Type, PlotFlag, NumFig)

s = RandStream('mt19937ar','Seed',1);
RandStream.setGlobalStream(s);

RAND_SEED = randn(NumOfSimulation, DayCount);

S_path = Spot*cumprod(exp((RiskFree - Dividend - 0.5 * Volatility * Volatility)/BasedYears + Volatility * sqrt(1/BasedYears) * RAND_SEED), 2);
S_path_anti = Spot*cumprod(exp((RiskFree - Dividend - 0.5*Volatility*Volatility)/BasedYears - Volatility*sqrt(1/BasedYears)*RAND_SEED), 2);

if PlotFlag == 1
    figure(NumFig)
    plot(0:DayCount, [Spot*ones(size(S_path,1),1), S_path(:,1:end)]);
    title('BS 1D - MC Simulation(Antitheric)');
    xlabel('Tau');ylabel('Payoff');
end

if strcmp(Type,'Call')
    Payoff_Set = max((S_path(:,end) - Strike),0);
    Payoff_Set_anti = max((S_path_anti(:,end) - Strike),0); 
elseif strcmp(Type, 'Put')
    Payoff_Set = max((Strike-S_path(:,end)),0);
    Payoff_Set_anti = max((Strike-S_path_anti(:,end)),0);
end

Tau = DayCount/BasedYears;
Price1 = mean(Payoff_Set)*exp(-(RiskFree-Dividend)*Tau);
Price2 = mean(Payoff_Set_anti)*exp(-(RiskFree-Dividend)*Tau);
Price = 0.5*(Price1+Price2);
end