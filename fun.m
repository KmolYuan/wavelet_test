function fval = fun(x)
global level x_ac2 x_detail2 y_ac2 y_detail2
persistent err
if isempty(err)
    err = @(x1, x2) sum(abs(x1 - x2));
end

a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
len(1:5) = x(5:9);
path = build_fourbar(a0, b0, len);
path(isnan(path)) = 5e3;
[x_ac1, x_detail1] = decomposition(real(path), level);
[y_ac1, y_detail1] = decomposition(imag(path), level);

ac1 = [x_ac1, y_ac1];
ac2 = [x_ac2, y_ac2];
detail1 = [x_detail1, y_detail1];
detail2 = [x_detail2, y_detail2];
fval(1) = err(ac1, ac2);
fval(2:level + 1) = 0;
for i = 1:level
    fval(i + 1) = err(detail1{i}, detail2{i});
end
end
