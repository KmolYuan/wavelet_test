clear; close all

load path
new_path = normalization(path);
figure
plot(real(path), imag(path))
hold on
plot(real(new_path), imag(new_path))
