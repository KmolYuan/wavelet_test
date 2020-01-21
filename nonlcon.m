function [c, ceq] = nonlcon(x)
global min_link
a0 = x(1) + x(2) * 1j;
b0 = x(3) + x(4) * 1j;
ground = abs(a0 - b0);

c(1) = x(7) - x(8) + x(9);
c(2) = x(8) - x(9) + x(7);
c(3) = x(9) - x(7) + x(8);
c(4) = ground + x(5) - x(6) - x(7);
c(5) = min_link - ground;

ceq = [];
end
