function new_path = normalization(path)
c = struct;
for i = 1:length(path)
    c(i).x = real(path(i));
    c(i).y = imag(path(i));
end
len(1:length(c) + 1) = 0;
centre = struct('x', 0, 'y', 0);
for i = 1:length(c)
    if i - 1 < 1
        continue
    end
    c1 = c(i);
    c2 = c(i - 1);
    len(i) = hypot(c2.x - c1.x, c2.y - c1.y);
    centre.x = centre.x + (c2.x + c1.x) * len(i);
    centre.y = centre.y + (c2.y + c1.y) * len(i);
end
len(end) = sum(len);
centre.x = centre.x / (2 * len(end));
centre.y = centre.x / (2 * len(end));
inertia = [0, 0, 0];  % xx, yy, xy
for i = 1:length(c)
    if i - 1 < 1
        continue
    end
    c1 = c(i);
    c2 = c(i - 1);
    inertia(1) = inertia(1) + len(i) * (...
        (c2.y - centre.y)^2 +...
        (c1.y - centre.y)^2 +...
        (c2.y - centre.y) * (c1.y - centre.y));
    inertia(2) = inertia(2) + len(i) * (...
        (c2.x - centre.x)^2 +...
        (c1.x - centre.x)^2 +...
        (c2.x - centre.x) * (c1.x - centre.x));
    inertia(3) = inertia(3) + len(i) * (...
        (c2.x - centre.x) * (c1.y - centre.y) +...
        (c1.x - centre.x) * (c2.y - centre.y)) +...
        2 * ((c2.x - centre.x) * (c2.y - centre.y) +...
             (c1.x - centre.x) * (c1.y - centre.y));
end
inertia = inertia ./ [3, 3, 6];
alpha = 0.5 * atan2(2 * inertia(3), inertia(2) - inertia(1));
if inertia(1) > inertia(2)
    alpha = alpha + pi / 2;
end
bound = [min([c.x]), max([c.x]), min([c.y]), max([c.y])];
w = bound(2) - bound(1);
tm = [cos(alpha) / w, sin(alpha) / w, -bound(1) / w;
      -sin(alpha) / w, cos(alpha) / w, -bound(3) / w;
      0, 0, 1];
new_path(1:length(c)) = 0;
for i = 1:length(c)
    t = tm * [c(i).x; c(i).y; 1];
    new_path(i) = t(1) + t(2) * 1j;
end
end
