%% FIGURE1_SIM - Reproduce Figure 1 from the paper

clear all; close all; clc;

% Parameters from the paper
r_i1 = 1.2; r_i2 = 0.8;
r_j1 = 0.9; r_j2 = 1.1;
s_ii1 = 0.05; s_ii2 = 0.06;
s_jj1 = 0.06; s_jj2 = 0.05;
s_ij1 = 0.04; s_ij2 = 0.07;
s_ji1 = 0.07; s_ji2 = 0.04;

Z1=48; %%%from the paper%%%
theta = 0.3;
Z2=theta * Z1;
T=0.1;
delta=0.35;
K = 100;

% Define vector fields
f1 = @(x) [r_i1*Z1*(1/(1+x(2)))*x(1) - s_ii1*x(1)^2 - s_ij1*x(1)*x(2);
           r_j1*Z1*(1/(1+x(1)))*x(2) - s_jj1*x(2)^2 - s_ji1*x(1)*x(2)];

f2 = @(x) [r_i2*Z2*(1/(1+x(2)))*x(1) - s_ii2*x(1)^2 - s_ij2*x(1)*x(2);
           r_j2*Z2*(1/(1+x(1)))*x(2) - s_jj2*x(2)^2 - s_ji2*x(1)*x(2)];

% Switching function
sigma = @(t) (mod(t, T)<delta*T)+1;

% Initial conditions from the paper
IC = [20 20; 25 40; 45 45; 55 55; 35 35];

% Colors for plotting
colors = lines(5);

% Create figure
figure('Position', [100 100 1200 500]);

% Subplot 1: Population dynamics
subplot(1,2,1);
hold on; grid on;
for i = 1:5
    [t, x] = integrate_switched_LV(f1, f2, sigma, [0 50], IC(i,:), 1e-4);
    plot(t, x(:,1), 'Color', colors(i,:), 'LineWidth', 1.5);
    plot(t, x(:,2), 'Color', colors(i,:), 'LineWidth', 1.5, 'LineStyle', '--');
end
xlabel('Time');
ylabel('Population density');
title('Species dynamics under environmental switching');
legend('x_i (species i)', 'x_j (species j)');

% Subplot 2: Resource access probability
subplot(1,2,2);
hold on; grid on;
[t, x] = integrate_switched_LV(f1, f2, sigma, [0 50], IC(1,:), 1e-4);
prob_i = 1./(1 + x(:,1));
prob_j = 1./(1 + x(:,2));
plot(t, prob_i, 'b', 'LineWidth', 2);
plot(t, prob_j, 'y', 'LineWidth', 2);
xlabel('Time');
ylabel('Resource access probability');
title('Resource accessibility functions');
legend('1/(1+x_i)', '1/(1+x_j)');
ylim([0 1]);

% Save figure
%saveas(gcf, 'Figure1.png');
%%%by BAIdy%%%%%
