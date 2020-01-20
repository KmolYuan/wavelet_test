function fval = obj(x)
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
x_error = 0;
y_error = 0;
for i = 1:length(x_detail1)
    x_error = x_error + err(x_detail1{i}, x_detail2{i});
    y_error = y_error + err(y_detail1{i}, y_detail2{i});
end
fval = err(x_ac1, x_ac2) + err(y_ac1, y_ac2) + x_error + y_error;
end
