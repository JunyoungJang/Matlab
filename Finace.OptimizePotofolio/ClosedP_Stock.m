function DATA = ClosedP_Stock(code)
WebSite=urlread(sprintf('https://www.google.com/finance/historical?q=%s&start=0&num=90',code));
DateIndex=strfind(WebSite,'<td class="lm">');
ClosePIndex0=strfind(WebSite,'<td class="rgt">');
ClosePIndex1=strfind(WebSite,'<td class="rgt rm">');
for i = 1:90
    raw_date{i,1} = WebSite(DateIndex(i)+15:ClosePIndex0(i+3*(i-1))-1);
    raw_closedP{i,1} = WebSite(ClosePIndex0(4*i)+16:ClosePIndex1(i)-1);
    
    date(i,1) = str2double(datestr(datenum(raw_date{i,1}),'yyyymmdd'));
end
closedP = str2double(raw_closedP);
DATA = [date, closedP];
end