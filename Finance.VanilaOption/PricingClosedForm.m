function Price = PricingClosedForm(Spot, Strike, RiskFree, Tau, Volatility, Dividend,Type)
d1 = (log(Spot/Strike) + ((RiskFree - Dividend) + Volatility^2/2)*Tau) / (Volatility * sqrt(Tau));
d2 = d1 - (Volatility * sqrt(Tau));
if strcmp(Type, 'Call')
    Price = Spot * normdistcdf(d1) - Strike * (exp(-(RiskFree - Dividend)* Tau) * normdistcdf(d2));
elseif strcmp(Type, 'Put')
    Price = Strike * exp(-(RiskFree - Dividend) * Tau) * normdistcdf (-d2) - Spot * normdistcdf(-d1);
end
end