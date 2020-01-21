clear; close all

load path
name = {'X Axis', 'Y Axis'};
path = [path, path(1)];  % Back to head
curve = {real(path), imag(path)};
level = 3;
scales = 1;
wname = 'db3';

tic
full_figure('Target Path')
draw_curve(name, curve)
full_figure('Wavelet Decomposition')
for i = 1:2
    decompose_wavelet(name{i}, curve{i}, i, level, wname)
end
full_figure('Discrete Wavelet Transform')
for i = 1:2
    dwt_plot(name{i}, curve{i}, i, wname)
end

full_figure('Continuous Wavelet Transform')
for i = 1:2
    cwt_plot(name{i}, curve{i}, i, scales)
end
toc

function varargout = full_figure(name)
fig = figure('Name', name);
fig.WindowState = 'maximized';  % R2018a
if nargout == 1
    varargout{1} = fig;
end
end

function draw_curve(name, curve)
subplot(2, 2, [1, 3])
plot(curve{1}, curve{2})
grid on
title('Target path')
for i = 1:2
    subplot(2, 2, i * 2)
    plot(curve{i})
    grid on
    title(name{i})
end
end

function decompose_wavelet(name, path, index, level, wname)
persistent col
if isempty(col)
    col = 2;
end
[c, l] = wavedec(path, level, wname);
row = 1 + level;
subplot(row, col, index)
plot(appcoef(c, l, wname))
grid on
title(['Approximation Coefficients of ', name])
detail(1:level) = detcoef(c, l, 1:level);
for i = 1:level
    subplot(row, col, index + i * 2)
    plot(detail{i})
    grid on
    title([sprintf('Level %i Detail Coefficients of ', i), name])
end
end

function dwt_plot(name, path, index, wname)
[a, d] = dwt(path, wname);
subplot(3, 2, index)
plot(a)
grid on
title(['Approximation Coefficients of ', name])
subplot(3, 2, index + 2)
plot(d)
grid on
title(['Detail Coefficients of ', name])
new_path = idwt(a, d, wname);
subplot(3, 2, index + 4)
plot(new_path)
grid on
title(['Inverse Wavelet Transformation of ', name])
end

function cwt_plot(name, path, index, scales)
subplot(1, 2, index)
img = wscalogram('', cwt(path, scales), 'scales', scales, 'ydata', path);
imagesc(1:length(path), scales, img)
title(['Magnitude Scalogram of ', name])
end
