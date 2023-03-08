function [xDot] = VCPEndDotCB(a1, a2, b0, x, u)

%computing xDot(1)
xDot(1) = x(2) + b0 * cos(x(1)) * u;

%computing xDot(2)
xDot(2) = -a2 * sin(x(1)) - a1 * x(2) + (b0 * sin(x(1)) - a1 * b0 * cos(x(1))) * u; 

%computing xDot(3)
xDot(3) = cos(x(1)) * u;

%computing xDot(4)
xDot(4) = x(3);

end 