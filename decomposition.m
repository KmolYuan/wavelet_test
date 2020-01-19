function [approx_coeff, detail] = decomposition(path, level)
[c, l] = wavedec(path, level, 'db2');
approx_coeff = appcoef(c, l, 'db2');
detail(1:level) = detcoef(c, l, 1:level);
end
