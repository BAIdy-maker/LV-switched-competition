%% SENSITIVITY_ANALYSIS - Parameter sensitivity analysis

clear all; close all; clc;

% Base parameters
base_params = struct();
base_params.r_i1=1.2;   base_params.r_i2 = 0.8;
base_params.r_j1=0.9;   base_params.r_j2 = 1.1;
base_params.s_ii1=0.05; base_params.s_ii2 = 0.06;
base_params.s_jj1=0.06; base_params.s_jj2 = 0.05;
base_params.s_ij1=0.04; base_params.s_ij2 = 0.07;
base_params.s_ji1=0.07; base_params.s_ji2 = 0.04;
base_params.Z1 = 48;
base_params.theta=0.3;
base_params.delta=0.35;
base_params.T = 0.1;

% Parameter names for display
param_names={'r_i1', 'r_i2', 'r_j1', 'r_j2','s_ii1', 's_ii2', 's_jj1', 's_jj2','s_ij1', 's_ij2', 's_ji1', 's_ji2','Z_1', 'theta', 'delta', 'T'};

% Number of variations
n_variations=100;
outcomes=zeros(n_variations, 3); % [excl_i, excl_j, coexistence]

fprintf('Running sensitivity analysis (%d parameter sets)...\n', n_variations);

for k = 1:n_variations
    params = base_params;
    fields = fieldnames(params);
    for f = 1:length(fields)
        base_val = params.(fields{f});
        % Random variation between 0.8 and 1.2 times base value
        params.(fields{f}) = base_val * (0.8 + 0.4*rand());
    end
    
    % Define system with varied parameters
    Z2=params.theta * params.Z1;
    
    f1=@(x)[params.r_i1*params.Z1*(1/(1+x(2)))*x(1) - params.s_ii1*x(1)^2 - params.s_ij1*x(1)*x(2);
               params.r_j1*params.Z1*(1/(1+x(1)))*x(2) - params.s_jj1*x(2)^2 - params.s_ji1*x(1)*x(2)];
    
    f2=@(x)[params.r_i2*Z2*(1/(1+x(2)))*x(1) - params.s_ii2*x(1)^2 - params.s_ij2*x(1)*x(2);
               params.r_j2*Z2*(1/(1+x(1)))*x(2) - params.s_jj2*x(2)^2 - params.s_ji2*x(1)*x(2)];
    
    sigma=@(t)(mod(t, params.T)<params.delta*params.T)+1;
    
    % Test with 5 random initial conditions
    n_tests = 5;
    results = zeros(n_tests, 1);
    
    for test = 1:n_tests
        x0 = 100 * rand(1, 2); % Random initial between 0 and 100
        [~, x] = integrate_switched_LV(f1, f2, sigma, [0 100], x0, 1e-3);
        
        x_final = x(end, :);
        if x_final(1) < 0.1
            results(test) = 2; % Species i excluded
        elseif x_final(2) < 0.1
            results(test) = 1; % Species j excluded
        else
            results(test) = 3; % Coexistence
        end
    end
    
    % Store outcome proportions
    outcomes(k, 1) = sum(results == 1)/n_tests; % Exclusion of j
    outcomes(k, 2) = sum(results == 2)/n_tests; % Exclusion of i
    outcomes(k, 3) = sum(results == 3)/n_tests; % Coexistence
    
    % Display progress
    if mod(k, 20) == 0
        fprintf('  Completed %d/%d\n', k, n_variations);
    end
end

% Display summary
fprintf('\nSensitivity analysis complete.\n');
fprintf('Average outcomes across all parameter variations:\n');
fprintf('  Exclusion of species j: %.2f%%\n', 100*mean(outcomes(:,1)));
fprintf('  Exclusion of species i: %.2f%%\n', 100*mean(outcomes(:,2)));
fprintf('  Coexistence: %.2f%%\n', 100*mean(outcomes(:,3)));

% Plot results
figure('Position', [100 100 800 400]);

subplot(1,2,1);
boxplot(outcomes, 'Labels', {'Excl. j', 'Excl. i', 'Coexistence'});
ylabel('Proportion');
title('Outcome variability');

subplot(1,2,2);
histogram(outcomes(:,3), 20);
xlabel('Coexistence proportion');
ylabel('Frequency');
title('Distribution of coexistence outcomes');
grid on;

% Save results
%save('sensitivity_results.mat', 'outcomes');
%saveas(gcf, 'sensitivity_analysis.png');

    %%%by BAIdy%%%%%
