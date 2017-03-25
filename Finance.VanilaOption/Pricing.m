clear all
PlotFlag = 0; % 0 : off / 1: on
Type = 'Call';

BasedYears = 365;
IssueDate = '2016-01-01';
EvalDate = '2016-11-10';
MaturityDate = '2017-02-10';
DayCount = (datenum(MaturityDate) - datenum(EvalDate));
Tau = DayCount/BasedYears;

Spot = 300;
Strike = 210;
Rate = 0.1;
Dividend = 0.2;
Volatility = 0.2;

fprintf('\n\n\n\n');
fprintf(' - Spot(LastPrice) %.2f\n - Strike          %.2f\n - Rate             %.2f%%\n - Dividend         %.2f%%\n - Volatility       %.2f%%\n', ...
    Spot, Strike, Rate*100, Dividend*100, Volatility*100);

ClosedPrice = PricingClosedForm(Spot, Strike, Rate, Tau, Volatility, Dividend, Type);
fprintf(2,'Pricing - BLS Call            : %10.5f\n', ClosedPrice);

NumOfSimulation = 50000;
Price = PricingMC(Spot, Strike, Rate, Dividend, Volatility, NumOfSimulation, BasedYears, DayCount, Type, 1, 1);
fprintf('Pricing - MC Call             : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

Price = PricingMC_Antitheric(Spot, Strike, Rate, Dividend, Volatility, NumOfSimulation, BasedYears, DayCount, Type, PlotFlag, 2);
fprintf('Pricing - MC(Antitheric) Call : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

NumOfTGrid = 100;
NumOfSGrid = 100;

Price = PricingFDMExpl(Spot, Strike, Rate, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, PlotFlag, 3);
fprintf('Pricing - FDM(Explicit) Call  : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

Price = PricingFDMImpl(Spot, Strike, Rate, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, PlotFlag, 4);
fprintf('Pricing - FDM(Implicit) Call  : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

Price = PricingFDMCN(Spot, Strike, Rate, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, 0, 5);
fprintf('Pricing - FDM(C-N) Call       : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));


fprintf('\n\n\n\n');
Spot = 100;
Strike = 210;
Rate = 0.1;
Dividend = 0.2;
Volatility = 0.2;
Type = 'Put';

fprintf(' - Spot(LastPrice) %.2f\n - Strike          %.2f\n - Rate             %.2f%%\n - Dividend         %.2f%%\n - Volatility       %.2f%%\n', ...
    Spot, Strike, Rate*100, Dividend*100, Volatility*100);

ClosedPrice = PricingClosedForm(Spot, Strike, Rate, Tau, Volatility, Dividend, Type);
fprintf(2,'Pricing - BLS Put            : %10.5f\n', ClosedPrice);

NumOfSimulation = 50000;
Price = PricingMC(Spot, Strike, Rate, Dividend, Volatility, NumOfSimulation, BasedYears, DayCount, Type, PlotFlag, 1);
fprintf('Pricing - MC Put             : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

Price = PricingMC_Antitheric(Spot, Strike, Rate, Dividend, Volatility, NumOfSimulation, BasedYears, DayCount, Type, PlotFlag, 2);
fprintf('Pricing - MC(Antitheric) Put : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

NumOfTGrid = 100;
NumOfSGrid = 100;

Price = PricingFDMExpl(Spot, Strike, Rate, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, PlotFlag, 3);
fprintf('Pricing - FDM(Explicit) Put  : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

Price = PricingFDMImpl(Spot, Strike, Rate, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, PlotFlag, 4);
fprintf('Pricing - FDM(Implicit) Put  : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));

Price = PricingFDMCN(Spot, Strike, Rate, Dividend, Volatility, DayCount, BasedYears, NumOfTGrid, NumOfSGrid, Type, 0, 5);
fprintf('Pricing - FDM(C-N) Put       : %10.5f / Prce diff = %0.5f\n', Price, abs(ClosedPrice-Price));
