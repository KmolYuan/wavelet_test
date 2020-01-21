function draw_linkage(x, target_path)
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
len(1:5) = x(5:9);
path_new = build_fourbar(a0, b0, len);
theta = 45;
a1 = a0 + len(1) * (cos(theta) + sin(theta) * 1j);
b1 = pllp(a1, len(2), len(3), b0);
p = pllp(a1, len(4), len(5), b1);
figure
hold on
link(a0, a1, '.-b')
link(a1, b1)
link(b0, b1)
link(a1, p)
link(b1, p)
plot(real(path_new), imag(path_new))
plot(real(target_path), imag(target_path))
grid on
pbaspect([1, 1, 1])

    function link(p1, p2, varargin)
        if nargin == 3
            color = varargin{1};
        else
            color = '.-k';
        end
        plot([real(p1), real(p2)], [imag(p1), imag(p2)], color)
    end

end
