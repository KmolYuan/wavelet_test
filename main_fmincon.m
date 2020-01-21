clear; close all

load path
global N level wname x_ac2 x_detail2 y_ac2 y_detail2
N = length(path);  % The lenth of the path
level = 3;  % The level of decomposition
wname = 'db3';  % Daubechies¡¦ orthogonal function wavelets D3
[x_ac2, x_detail2] = decomposition(real(path), level);
[y_ac2, y_detail2] = decomposition(imag(path), level);

tic
% x0 = [a0x, a0y, b0x, b0y, l1, l2, l3, l4, l5];
x0 = [0, 0, 50, 0, 30, 53.85, 50, 50, 58.31];
ub = [-9e9, -9e9, -9e9, -9e9, 5, 5, 5, 5, 5];
opt = optimoptions(@fmincon, 'Algorithm', 'sqp', 'Display', 'off');
[x, fval, flag, out] = fmincon(@obj, x0, [], [], [], [], ub, [], @nonlcon, opt);
% opt = optimoptions(@ga, 'Display', 'off', 'MaxGenerations', 500, 'PopulationSize', 500);
% [x, fval, flag, out] = ga(@obj, 9, [], [], [], [], ub, [], @nonlcon, opt);
fprintf('iter: %i\n', out.iterations)
fprintf('exit: %i\n', flag)
fprintf('f(%f, %f, %f, %f, %f, %f, %f, %f, %f) = %f\n', x, fval)
draw_linkage(x, path)
toc
