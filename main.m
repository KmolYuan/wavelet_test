clear; close all; clc;

load path
global N level x_ac2 x_detail2 y_ac2 y_detail2
N = length(path);  % The lenth of the path
level = 3;  % The level of decomposition
[x_ac2, x_detail2] = decomposition(real(path), level);
[y_ac2, y_detail2] = decomposition(imag(path), level);

% x0 = [a0x, a0y, b0x, b0y, l1, l2, l3, l4, l5];
x0 = [0, 0, 50, 0, 30, 53.85, 50, 50, 58.31];
opt = optimoptions(@fmincon, 'Algorithm', 'sqp', 'Display', 'off');
[x, fval, flag, out] = fmincon(@obj, x0, [], [], [], [], [], [], @nonlcon, opt);
fprintf('iter: %i\n', out.iterations);
fprintf('exit: %i\n', flag);
fprintf('f(%f, %f, %f, %f, %f, %f, %f, %f, %f) = %f\n', x, fval);
draw_linkage(x, path)
