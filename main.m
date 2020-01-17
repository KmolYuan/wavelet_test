clear; close all; clc;

load path
global xa2 xd2 ya2 yd2
[xa2, xd2] = dwt(real(path), 'sym4');
[ya2, yd2] = dwt(imag(path), 'sym4');

x0 = [0, 0, 0, 70, repelem(5, 5)];
opt = optimoptions(@fmincon, 'Algorithm', 'sqp', 'Display', 'off');
[x, fval, flag] = fmincon(@objective, x0, [], [], [], [], [], [], @nonlcon, opt);
fprintf("exit: %i\n", flag);
fprintf("f(%f, %f, %f, %f, %f, %f, %f, %f, %f) = %f\n", x, fval);
