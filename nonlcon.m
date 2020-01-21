function [c, ceq] = nonlcon(x)
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
ground = abs(a0 - b0);
len(1:4) = sort([x(5:7), ground]);

c(1) = x(7) - x(8) + x(9);
c(2) = x(8) - x(9) + x(7);
c(3) = x(9) - x(7) + x(8);
c(4) = len(3) + len(4) - len(1) + len(2);
c(5:10) = 5 - ground;

ceq = [];
end
