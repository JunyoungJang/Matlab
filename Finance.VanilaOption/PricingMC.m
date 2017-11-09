function Price=PricingMC(Spot, Strike, RiskFree, Dividend, Volatility, NumOfSimulation, BasedYears, DayCount, Type, PlotFlag, NumFig)

s = RandStream('mt19937ar','Seed',1);
RandStream.setGlobalStream(s);

RandomSample = randn(NumOfSimulation, DayCount);

S_path=Spot * cumprod(exp((RiskFree-Dividend - 0.5 * Volatility.^2)/BasedYears + Volatility * sqrt(1/BasedYears) * RandomSample), 2);

if PlotFlag == 1
    figure(NumFig)
    plot(0:DayCount, [Spot*ones(size(S_path,1),1), S_path(:,1:end)]);
    title('BS 1D - MC Simulation');
    xlabel('Tau');ylabel('Payoff');
end

if strcmp(Type,'Call')
    Payoff_Set = max((S_path(:,end) - Strike),0);
elseif strcmp(Type, 'Put')
    Payoff_Set = max((Strike - S_path(:,end)),0);
end

Tau = DayCount/BasedYears;
Price = mean(Payoff_Set)*exp(-(RiskFree-Dividend)*Tau);
end