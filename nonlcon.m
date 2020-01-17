function [c, ceq] = nonlcon(x)
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
length = sort([x(5:8), abs(a0 - b0)]);
c(1) = length(3) + length(4) - length(1) + length(2);
ceq = [];
end
