%%%%analyse de sensibilité cas BALANCED%%%%

%%%%clear; close all; clc;

% Sensitivity data for BALANCED case from paper

param_names={'r_{i1}''', 'r_{j1}''', 's_{ii1}', 's_{jj1}', 's_{ij1}', 's_{ji1}', '\theta', '\delta'};
mu_star=[0.45, 0.42, 0.38, 0.35, 0.28, 0.25, 0.18, 0.12];  % Lower sensitivity in balanced case
sigma=[0.08, 0.09, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02];    % Smaller deviations

% Create figure
figure('Position', [100, 100, 900, 400], 'Color', 'w', 'Name', 'Sensitivity: Balanced Effects');

%% Left panel: Bar plot
subplot(1, 2, 1);
hbar = barh(mu_star);
set(hbar, 'FaceColor', [0.1, 0.6, 0.3], 'EdgeColor', 'none', 'BarWidth', 0.7); % Green for balanced
hold on;

% Error bars
for i = 1:length(mu_star)
    plot([mu_star(i)-sigma(i), mu_star(i)+sigma(i)], [i, i],'k-', 'LineWidth', 1.2, 'Color', [0.3, 0.3, 0.3]);
    plot([mu_star(i)-sigma(i), mu_star(i)-sigma(i)], [i-0.15, i+0.15],'k-', 'LineWidth', 1.2, 'Color', [0.3, 0.3, 0.3]);
    plot([mu_star(i)+sigma(i), mu_star(i)+sigma(i)], [i-0.15, i+0.15],'k-', 'LineWidth', 1.2, 'Color', [0.3, 0.3, 0.3]);
end

% Formatting
set(gca, 'YTick', 1:length(param_names),'YTickLabel', param_names,'FontSize', 10, 'TickDir', 'out', 'Box', 'off');
xlabel('Sensitivity Index (\mu^*)', 'FontSize', 12, 'FontWeight', 'bold');
title('A) Balanced Competition Effects', 'FontSize', 13, 'FontWeight', 'bold');
grid on;
grid minor;
xlim([0, 0.6]);  
ylim([0.3, length(param_names)+0.7]);
set(gca, 'XColor', [0.4, 0.4, 0.4], 'YColor', [0.4, 0.4, 0.4]);


subplot(1, 2, 2);

% Scatter with consistent colors
colors = parula(length(mu_star));
for i = 1:length(mu_star)
    scatter(mu_star(i), sigma(i), 100, 'filled','MarkerFaceColor', colors(i,:),'MarkerEdgeColor', 'k', 'LineWidth', 1);
    hold on;
end

% Labels
for i = 1:length(param_names)
    text(mu_star(i) + 0.008, sigma(i) + 0.003, param_names{i},'FontSize', 9, 'HorizontalAlignment', 'left');
end

% Formatting
xlabel('\mu^* (Mean Effect)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('\sigma (Std Deviation)', 'FontSize', 12, 'FontWeight', 'bold');
title('B) Parameter Interactions', 'FontSize', 13, 'FontWeight', 'bold');
grid on;
grid minor;
xlim([0.1, 0.5]);
ylim([0.01, 0.12]);
set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 10);

%%%%%%%Note D'interpretation 
text(0.15, 0.11, 'Note: Lower sensitivity in balanced case','FontSize', 9, 'Color', [0.3, 0.3, 0.3], 'FontAngle', 'italic');

%% Adjust and save
% Adjust subplot positions
subplot(1, 2, 1);
pos1=get(gca, 'Position');
set(gca, 'Position', [pos1(1), pos1(2), pos1(3)*0.95, pos1(4)]);

subplot(1, 2, 2);
pos2=get(gca, 'Position');
set(gca, 'Position', [pos2(1)*0.98, pos2(2), pos2(3)*0.95, pos2(4)]);



%%%%%byBAIdy%%%%%
