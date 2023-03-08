function [y, tout, xout] = myStateSpaceIntergrator (VCPEndDotCB, a1, a2, b0, C, D, K, L, t, x0)

% get signal length
len = length(t) -1;

% init output
y = zeros(1,len);
xout = zeros(4,len); %this has been updated from 2 to 4 

% record the initial state
xout(:, 1, :, :) = x0;
x = x0;
xHat = x0;

%set the control for the system
u = - (K * xHat(1)) - (K(2) * xHat(2)) - (K(3) * x(3)) - (K(4) * x(4)); 
      
% for all remaining data points, simulate state-space model using C-language
%compatible formulation
for idx = 1:len
         
    % record time
    tout(idx) = t(idx);

    % get the duration between updates
    h = t(idx+1) - t(idx);
    
    %the observer estimated state feedback to compute U = -KX. This uses
    %the sfc gain, K, and xHat(1), xHat(2), x3, and x4
    u = - (K(1) * xHat(1)) - (K(2) * xHat(2)) - (K(3) * x(3)) - (K(4) * x(4));
    
    %calculate the real output using c compataile coding techniques
    y(1) = C(1) * x(1) + D(1) * u;
    y(2) = C(2) * x(2) + D(2) * u;
    y(3) = C(3) * x(3) + D(3) * u;
    y(4) = C(4) * x(4) + D(4) * u;
    
    % calculate state derivative from non-linear pendulum equations
    xDot = VCPEndDotCB(a1, a2, b0, x, u);
    
    %use the control velocity from the input
    xHatDot = VCPEndDotCB(a1, a2, b0, x, u);
    
    % update the state using Euler integration using c compataile coding techniques
    x(1) = x(1) + h * xDot(1);
    x(2) = x(2) + h * xDot(2);
    x(3) = x(3) + h * xDot(3);
    x(4) = x(4) + h * xDot(4);
    
    
    %calculating the observer correction term using c compataile coding 
    %techniques
    ycorr(1) = L(1) * (y(1) - C(1) * xHat(1));
    ycorr(2) = L(2) * (y(2) - C(2) * xHat(2));
    
    %update the observer state xHat using Euler intergration using c 
    %compataile coding techniques
    xHat(1) = xHat(1) + h * (xHatDot(1) + ycorr(1));
    xHat(2) = xHat(2) + h * (xHatDot(2) + ycorr(2));
    
    %record the state
    xout(:, idx) = x;
        
    % calculate output from theta and thetaDot state
    y(idx)= C(1) * xHat(1) + C(2) * xHat(2) + C(3) * xHat(3) + C(4) * xHat(4) + D(1) * u;
end

end