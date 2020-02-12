clear; close all

load path
last_path = path;
figure
plot(real(path), imag(path))
for i = 1:5
    hold on
    new_path = normalization(last_path);
    plot(real(new_path), imag(new_path))
    last_path = new_path;
end
