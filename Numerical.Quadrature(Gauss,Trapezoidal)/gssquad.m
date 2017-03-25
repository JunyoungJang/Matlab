function int = gssquad(f, a, b, n)

c = -1;
d = 1;

int = 0;
switch n
    case 1
        x = 0;
        w = 2;
        int = (b - a) / (d - c) * w * f((b - a)/(d - c) * x + (a * d - b * c)/(d - c));
    case 2
        x = [ -sqrt(1/3), sqrt(1/3)];
        w = [1, 1];
        for j = 1 : n
            int = int + (b - a)/(d - c) * w(j) * f((b - a)/(d - c) * x(j) + (a * d - b * c)/(d - c));
        end
    case 3
        x = [-sqrt(3/5), 0, sqrt(3/5)];
        w = [5/9, 8/9, 5/9];
        for j = 1 : n
            int = int + (b - a)/(d - c) * w(j) * f((b - a)/(d - c) * x(j) + (a * d - b * c)/(d - c));
        end
    case 4
        x = [sqrt((3 - 2 * sqrt(6/5))/7), -sqrt((3 - 2 * sqrt(6/5))/7), sqrt((3 + 2 * sqrt(6/5))/7), - sqrt((3 + 2 * sqrt(6/5))/7)];
        w = [(18 + sqrt(30))/36, (18 + sqrt(30))/36, (18 - sqrt(30))/36, (18 - sqrt(30))/36];
        for j = 1 : n
            int = int + (b - a)/(d - c) * w(j) * f((b - a)/(d - c) * x(j) + (a * d - b * c)/(d - c));
        end
    case 5
        x = [0, sqrt(5 - 2 * sqrt(10/7))/3, -sqrt(5 - 2 * sqrt(10/7))/3, sqrt(5 + 2 * sqrt(10/7))/3, -sqrt(5 + 2 * sqrt(10/7))/3];
        w = [128/225, (322+13*sqrt(70))/900, (322+13*sqrt(70))/900, (322-13*sqrt(70))/900, (322-13*sqrt(70))/900];
        for j = 1 : n
            int = int + (b - a)/(d - c) * w(j) * f((b - a)/(d - c) * x(j) + (a * d - b * c)/(d - c));
        end
    otherwise
        error('Choose the integer from 1 to 5');
end