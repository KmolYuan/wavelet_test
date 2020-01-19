clear; close all; clc;

load path
global N xa2 xd2 ya2 yd2
N = length(path);  % The lenth of the path
[xa2, xd2] = dwt(real(path), 'sym4');
[ya2, yd2] = dwt(imag(path), 'sym4');

x0 = [0, 0, 0, 50, repelem(50, 5)];
opt = optimoptions(@fmincon, 'Algorithm', 'sqp', 'Display', 'off');
[x, fval, flag] = fmincon(@obj, x0, [], [], [], [], [], [], @nonlcon, opt);
fprintf('exit: %i\n', flag);
fprintf('f(%f, %f, %f, %f, %f, %f, %f, %f, %f) = %f\n', x, fval);
