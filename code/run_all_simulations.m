%% on peut les compiler en même temps%%%%%%%

fprintf('Running all simulations from the paper...\n\n');

% Run Figure 1 simulation
fprintf('1. Running Figure 1 simulation...\n');
Figure1;
fprintf('Figure 1 completed.\n\n');

% Run sensitivity analysis for balanced
fprintf('2. Running sensitivity analysis...\n');
sensitivityanalysisforbalanced;
fprintf(' Sensitivity analysis for balanced completed.\n\n');

% Run sensitivity analysis for unbalanced
fprintf('3. Running sensitivity analysis...\n');
sensitivityanalysisforunbalanced;
fprintf(' Sensitivity analysis for unbalanced completed.\n\n');

fprintf('All simulations completed successfully.\n');
fprintf('Check the current folder for output figures.\n');
