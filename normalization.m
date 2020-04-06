function new_path = normalization(old_path)
path = struct;
for i = 1:length(old_path)
    path(i).x = real(old_path(i));
    path(i).y = imag(old_path(i));
end
len(1:length(path) + 1) = 0;
centre = struct('x', 0, 'y', 0);
for i = 1:length(path)
    c1 = path(i);
    if i - 1 < 1
        c2 = path(end);
    else
        c2 = path(i - 1);
    end
    len(i) = hypot(c2.x - c1.x, c2.y - c1.y);
    centre.x = centre.x + (c2.x + c1.x) * len(i);
    centre.y = centre.y + (c2.y + c1.y) * len(i);
end
len(end) = sum(len);
centre.x = centre.x / (2 * len(end));
centre.y = centre.x / (2 * len(end));
inertia = [0, 0, 0];  % xx, yy, xy
for i = 1:length(path)
    c1 = path(i);
    if i - 1 < 1
        c2 = path(end);
    else
        c2 = path(i - 1);
    end
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
elseif inertia(1) == inertia(2)
    alpha = 0;
end
bound = [min([path.x]), max([path.x]), min([path.y]), max([path.y])];
w = bound(2) - bound(1);
tm = [cos(alpha) / w, sin(alpha) / w, 0;
      -sin(alpha) / w, cos(alpha) / w, 0;
      0, 0, 1];
for i = 1:length(path)
    t = tm * [path(i).x; path(i).y; 1];
    path(i).x = t(1, 1);
    path(i).y = t(2, 1);
end
bound = [min([path.x]), max([path.x]), min([path.y]), max([path.y])];
new_path(1:length(path)) = 0;
for i = 1:length(path)
    new_path(i) = path(i).x - bound(1) + (path(i).y - bound(3)) * 1j;
end
end
