function [t, x] =integrate_switched_LV(f1, f2, sigma, tspan, x0, dt)
% INTEGRATE_SWITCHED_LV Integrate switched Lotka-Volterra system

if nargin<6
    dt=1e-4;
end

% Initialize
t=tspan(1):dt:tspan(2);
n = length(t);
x = zeros(n, 2);
x(1,:) = x0;

% Integration loop (Euler method for simplicity)
for k = 1:n-1
    if sigma(t(k)) == 1
        dx = f1(x(k,:)');
    else
        dx = f2(x(k,:)');
    end
    x(k+1,:) = x(k,:) + dt * dx';
end
end
%%%%%by BAIdy%%%%%%
