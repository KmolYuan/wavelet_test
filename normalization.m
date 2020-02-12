function new_path = normalization(path)
c = struct;
for i = 1:length(path)
    c(i).x = real(path(i));
    c(i).y = imag(path(i));
end
len = 0;
area = 0;
bound = [min([c.x]), max([c.x]), min([c.y]), max([c.y])];
for i = 1:length(c)
    if i - 1 < 1
        continue
    end
    c1 = c(i);
    c2 = c(i - 1);
    len = len + hypot(c1.x - c2.x, c1.y - c2.y);
    area = area + c2.x * c1.y - c1.x * c2.y;
end
w = bound(2) - bound(1);
centre = struct('x', 0, 'y', 0);
for i = 1:length(c)
    if i - 1 < 1
        continue
    end
    c1 = c(i);
    c2 = c(i - 1);
    tmp = hypot(c2.x - c1.x, c2.y - c1.y);
    centre.x = centre.x + (c2.x + c1.x) * tmp;
    centre.y = centre.y + (c2.y + c1.y) * tmp;
end
centre.x = centre.x / (2 * len);
centre.y = centre.x / (2 * len);
inertia = [0, 0, 0];  % xx, yy, xy
for i = 1:length(c)
    if i - 1 < 1
        continue
    end
    c1 = c(i);
    c2 = c(i - 1);
    len = hypot(c1.x - c2.x, c1.y - c2.y);
    inertia(1) = inertia(1) + len * (...
        (c2.y - centre.y)^2 +...
        (c1.y - centre.y)^2 +...
        (c2.y - centre.y) * (c1.y - centre.y));
    inertia(2) = inertia(2) + len * (...
        (c2.x - centre.x)^2 +...
        (c1.x - centre.x)^2 +...
        (c2.x - centre.x) * (c1.x - centre.x));
    inertia(3) = inertia(3) + len * (...
        (c2.x - centre.x) * (c1.y - centre.y) +...
        (c1.x - centre.x) * (c2.y - centre.y)) +...
        2 * ((c2.x - centre.x) * (c2.y - centre.y) +...
             (c1.x - centre.x) * (c1.y - centre.y));
end
inertia(1) = inertia(1) / 3;
inertia(2) = inertia(2) / 3;
inertia(3) = inertia(3) / 6;
alpha = 0.5 * atan2(2 * inertia(3), inertia(2) - inertia(1));
for i = 1:length(c)
    c(i).x = c(i).x * (cos(alpha) + sin(alpha) - bound(1)) / w;
    c(i).y = c(i).y * (-sin(alpha) + cos(alpha) - bound(4)) / w;
end
new_path = [c.x] + [c.y] * 1j;
end
