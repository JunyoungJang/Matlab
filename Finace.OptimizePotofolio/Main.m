clear all, close all, clc
WhenFrom = -inf;
WhenTo = 20170401;

%% Load and arrange data.
% Raw code data variable : xls_num.
% Arranged variable : Stock_Code, Stock_Name, closedP, rateOfreturn.
[~, xls_str] = xlsread('codedata.xlsx');                                            % Read Excel file of Stock code.
xls_str(1,:) = [];                                                                  % Delete category of data.
Stock_Code = xls_str(:,1);                                                          % Stock code of Google.
Stock_Name = xls_str(:,3)';                                                         % Stock name.
Stock_Num = size(Stock_Code,1);                                                     % the Number of stock in my potofolio.
closeP = zeros(90, Stock_Num);
for i = 1:Stock_Num
    DATA = ClosedP_Stock(cell2mat(Stock_Code(i)));                                  % This function help you to webcraler(90 days data).
    fprintf('[%02i/%d] Finish webcrawler from Google finance : stock - %s\n',...    % ClosedP_Stock( Input the code of Google fininace )
        i, Stock_Num, Stock_Name{i});                                               %   DATA = [YYYYMMDD, Closing Price]
    closeP(:, i) = DATA(:,2);                                                       % Closing Price variable.
end
date = DATA(:,1);                                                                   % Business day variable.

%% Select Date used above variable (WhenFrom ~ WhenTo)
ind = find(date>WhenFrom);s1 = max(ind);
ind = find(date<WhenTo);s0 = min(ind);
closeP = closeP(s0:s1,:);
date = date(s0:s1);

%% Calculate Daily rate of return of Selected Date
for i = 1:Stock_Num
    rateOfreturn.value(:,i) = -diff(closeP(:, i))./closeP(2:end, i);                % Daily rate of return for each firm.
    rateOfreturn.mean(i) = mean(rateOfreturn.value(:,i));                           % Mean value of Daily rate of return.
end                                                                                 % Business day variable.
rateOfreturn.cov = cov(rateOfreturn.value);    


%% QP Caculation using Opti Toolbox

% Objective
H = rateOfreturn.cov;                                                               %Objective Function (min 0.5x'Hx + f'x)
A = -rateOfreturn.mean;
Aeq = ones(1, Stock_Num);
f = zeros(1, Stock_Num);
b = -0.01;
beq = 1;
lb = zeros(Stock_Num, 1);
% Create OPTI Object
Opt = opti('qp',H,f,'ineq',A,b,'eq',Aeq,beq,'lb',lb);
[x,fval,exitflag,info] = solve(Opt);

f1 = figure;
plot(1:Stock_Num,x,'-o');hold on
ylabel('Weight');xlabel('Numbering Stock')
for i = 1:Stock_Num
    if x(i)>mean(x)
        plot(i, x(i),'ro')
    end
    text(i,x(i),sprintf('%d',i))
end
