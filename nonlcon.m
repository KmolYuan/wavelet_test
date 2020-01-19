function [c, ceq] = nonlcon(x)
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
length(1:4) = sort([x(5:7), abs(a0 - b0)]);

c(1) = length(3) + length(4) - length(1) + length(2);
c(2) = x(7) - x(8) + x(9);
c(3) = x(8) - x(9) + x(7);
c(4) = x(9) - x(7) + x(8);

ceq = [];
end
