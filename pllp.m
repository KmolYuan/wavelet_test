function p = pllp(c1, d0, d1, c2)
dp = c2 - c1;
d = abs(dp);
if d > d0 + d1 || d < abs(d0 - d1) || d == 0
    p = NaN;
    return
end
a = (d0 * d0 - d1 * d1 + d * d) / (2 * d);
h = sqrt(d0 * d0 - a * a);
m = c1 + a * dp / d;
p = real(m) - h * imag(dp) / d + (imag(m) + h * real(dp) / d) * 1j;
end
