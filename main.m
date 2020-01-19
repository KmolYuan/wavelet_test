clear; close all; clc;

load path
global N level x_ac2 x_detail2 y_ac2 y_detail2
N = length(path);  % The lenth of the path
level = 4;  % The level of decomposition
[x_ac2, x_detail2] = decomposition(real(path), level);
[y_ac2, y_detail2] = decomposition(imag(path), level);

x0 = [0, 0, 0, 50, repelem(50, 5)];
opt = optimoptions(@fmincon, 'Algorithm', 'sqp', 'Display', 'off');
[x, fval, flag] = fmincon(@obj, x0, [], [], [], [], [], [], @nonlcon, opt);
fprintf('exit: %i\n', flag);
fprintf('f(%f, %f, %f, %f, %f, %f, %f, %f, %f) = %f\n', x, fval);
