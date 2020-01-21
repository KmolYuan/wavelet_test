function [approx_coeff, detail] = decomposition(path, level)
global wname
[c, l] = wavedec(path, level, wname);
approx_coeff = appcoef(c, l, wname);
detail(1:level) = detcoef(c, l, 1:level);
end
