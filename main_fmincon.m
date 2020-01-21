clear; close all

load path
path = [path, path(1)];  % Back to head
global N level wname min_link x_ac2 x_detail2 y_ac2 y_detail2
N = length(path);  % The lenth of the path
level = 3;  % The level of decomposition
wname = 'db3';  % Daubechies¡¦ orthogonal function wavelets D3
min_link = 2.75;
[x_ac2, x_detail2] = decomposition(real(path), level);
[y_ac2, y_detail2] = decomposition(imag(path), level);

tic
% x0 = [a0x, a0y, b0x, b0y, l1, l2, l3, l4, l5];
x0 = [0, 0, 5, 0, 3, 4.176, 4.317, 2.4, 4.176];
lb = [-9e9, -9e9, -9e9, -9e9, repelem(min_link, 5)];
opt = optimoptions(@fmincon, 'Algorithm', 'sqp', 'Display', 'off');
[x, fval, flag, out] = fmincon(@obj, x0, [], [], [], [], lb, [], @nonlcon, opt);
fprintf('iter: %i\n', out.iterations)
% opt = optimoptions(@ga, 'Display', 'off', 'MaxGenerations', 500, 'PopulationSize', 500);
% [x, fval, flag, out] = ga(@obj, 9, [], [], [], [], lb, [], @nonlcon, opt);
fprintf('exit: %i\n', flag)
fprintf('a0: (%f, %f)\n', x(1:2))
fprintf('b0: (%f, %f)\n', x(3:4))
fprintf('l: [%f, %f, %f, %f, %f]\n', x(5:9))
draw_linkage(x, path)
toc
