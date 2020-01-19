function fval = obj(x)
global xa2 xd2 ya2 yd2
persistent err
if isempty(err)
    err = @(x1, x2) sum(abs(x1 - x2));
end
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
length(1:5) = x(5:9);
path = build_fourbar(a0, b0, length);
path(isnan(path)) = 0;
[xa1, xd1] = dwt(real(path), 'sym4');
[ya1, yd1] = dwt(imag(path), 'sym4');
fval = err(xa1, xa2) + err(xd1, xd2) + err(ya1, ya2) + err(yd1, yd2);
end
