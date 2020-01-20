clear; close all

load path
global N level x_ac2 x_detail2 y_ac2 y_detail2
N = length(path);  % The lenth of the path
level = 3;  % The level of decomposition
[x_ac2, x_detail2] = decomposition(real(path), level);
[y_ac2, y_detail2] = decomposition(imag(path), level);

tic
opt = optimoptions(@lsqnonlin, 'Display', 'off');
x0 = [0, 0, 50, 0, 30, 53.85, 50, 50, 58.31];
[x, resnorm, residual, flag, out] = lsqnonlin(@fun, x0, [], [], opt);
fprintf('iter: %i\n', out.iterations)
fprintf('exit: %i\n', flag)
fprintf('f(%f, %f, %f, %f, %f, %f, %f, %f, %f) = %f\n', x, resnorm)
draw_linkage(x, path)
toc
