%% RUN_ALL_SIMULATIONS - Main script to run all simulations
% This reproduces all figures from the paper

fprintf('Running all simulations from the paper...\n\n');

% Run Figure 1 simulation
fprintf('1. Running Figure 1 simulation...\n');
Figure1_sim;
fprintf('   Figure 1 completed.\n\n');

% Run sensitivity analysis
fprintf('2. Running sensitivity analysis...\n');
sensitivity_analysis;
fprintf('   Sensitivity analysis completed.\n\n');

fprintf('All simulations completed successfully.\n');
fprintf('Check the current folder for output figures.\n');
