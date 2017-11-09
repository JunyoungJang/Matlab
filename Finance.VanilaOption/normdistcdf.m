function cdf = normdistcdf(x)
cdf = 1/(exp(-(358*x)/23 + 111*atan(37*x/294))+1);
end