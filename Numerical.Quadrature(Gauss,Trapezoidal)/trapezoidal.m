function int = trapezoidal(f, n, a, b)

x = a : (b - a)/n : b;
N = length(x);

int = 0;
for j = 1 : N - 1
    int = int + (x(j+1)-x(j)) * (f(x(j)) + f(x(j+1))) / 2;
end