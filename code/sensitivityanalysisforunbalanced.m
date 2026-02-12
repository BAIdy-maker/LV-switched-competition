%%%%analyse de sensibilité cas UNBALANCED%%%%

%clear; close all; clc;

% Données de sensibilité
param_names={'r_{i1}', 'r_{j2}', 's_{ij1}', 's_{ji2}', '\theta', '\delta', 's_{ii1}', 's_{jj2}'};
mu_star=[0.82, 0.78, 0.65, 0.61, 0.58, 0.55, 0.32, 0.30];
sigma=[0.15, 0.18, 0.22, 0.20, 0.12, 0.10, 0.08, 0.09];

% Créer la figure
figure('Position', [100, 100, 800, 500]);

% Bar plot horizontal
subplot(1,2,1);
hbar=barh(mu_star);
set(hbar, 'FaceColor', [0.2, 0.4, 0.8]);
hold on;

% Barres d'erreur
for i = 1:length(mu_star)
    plot([mu_star(i)-sigma(i), mu_star(i)+sigma(i)], [i, i], 'k-', 'LineWidth', 2);
end

% Redéfinir les axes
set(gca, 'YTick', 1:length(param_names), 'YTickLabel', param_names);
xlabel('Sensitivity Index (\mu^*)', 'FontSize', 12);
title('Morris Elementary Effects', 'FontSize', 14);

xlim([0, 1]);
ylim([0.5, length(param_names)+0.5]);

%Graphique mu vs sigma
subplot(1,2,2);
scatter(mu_star, sigma, 100, 'filled', 'MarkerFaceColor', [0.8, 0.2, 0.2]);
hold on;

% Labels
for i=1:length(param_names)
    text(mu_star(i)+0.02, sigma(i)+0.01, param_names{i},'FontSize', 10, 'HorizontalAlignment', 'left');
end

% Lignes de référence
plot([0, 1], [0, 0.3], 'k--', 'LineWidth', 0.5);
plot([0.5, 0.5], [0, 0.3], 'k--', 'LineWidth', 0.5);

% Redéfinir les axes
xlabel('\mu^* (mean effect)', 'FontSize', 12);
ylabel('\sigma (std deviation)', 'FontSize', 12);
title('Parameter Nonlinearity', 'FontSize', 14);

xlim([0.2, 0.9]);
ylim([0, 0.25]);


%%%Edited by IdyBA%%%
