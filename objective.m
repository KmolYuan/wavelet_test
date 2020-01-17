function fval = objective(x)
global xa2 xd2 ya2 yd2
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
length(1:5) = x(5:9);
path = build_fourbar(a0, b0, length);
if isnan(path)
    fval = inf;
    return
end
[xa1, xd1] = dwt(real(path), 'sym4');
[ya1, yd1] = dwt(imag(path), 'sym4');
fval = sum(xa1 - xa2) + sum(xd1 - xd2) + sum(ya1 - ya2) + sum(yd1 - yd2);
end
