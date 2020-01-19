function path = build_fourbar(a0, b0, length)
% Return the path from the dimension.
% size(l) == 5.
global N

path(1:N) = 0;
theta = linspace(0, 2 * pi, N);
for i = 1:N
    a1 = a0 + length(1) * (cos(theta(i)) + sin(theta(i)) * 1j);
    b1 = pllp(a1, length(2), length(3), b0);
    p = pllp(a1, length(4), length(5), b1);
    if isnan(b1) || isnan(p)
        path(i) = NaN;
    else
        path(i) = p;
    end
end

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
        p = (real(m) - h * real(dp) / d) + (imag(m) + h * real(dp) / d) * 1j;
    end

end
