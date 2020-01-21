function path = build_fourbar(a0, b0, len)
% Return the path from the dimension. size(l) == 5.
global N
path(1:N) = 0;
theta = linspace(0, 2 * pi, N);
for i = 1:N
    a1 = a0 + len(1) * (cos(theta(i)) + sin(theta(i)) * 1j);
    b1 = pllp(a1, len(2), len(3), b0);
    p = pllp(a1, len(4), len(5), b1);
    if isnan(b1) || isnan(p)
        path(i) = NaN;
    else
        path(i) = p;
    end
end
end
