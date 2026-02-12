%%%%%%%%%%%%%%%%%% FIGURE 1 du papier%%%%%%%%%%
%%%%%%%%%%%Les figures 2 et 3 s'obtiennent en changeant les param. fixés
%clear; close all; clc;

%%%%%%%paramètres fixés necessite un choix critique%%%%%%%%%%%%%

%%%%%%%%%%env1%%%%%%%%%%%

r_i1_prime=1.2;
r_j1_prime=0.8;
s_ii1=0.09;   
s_ji1=0.045;  
s_ij1=0.12;   
s_jj1=0.10;   

%%%%%%%%%%env2%%%%%%%%%%%

r_i2_prime=1.0;
r_j2_prime=0.9;
s_ii2=0.08;   
s_ji2=0.055;  
s_ij2 = 0.15;  
s_jj2 = 0.08;  

Z1=50;
theta=0.6;
Z2=theta*Z1;
delta=0.5;    % 50% dans chaque environnement
K=100;%%%%ou assez grand

%%%%%%%%%%Calcul des param dans env moyen%%%%%%%%%%%

ri=delta*r_i1_prime+(1-delta)*theta*r_i2_prime;
rj=delta*r_j1_prime+(1-delta)*theta*r_j2_prime;

num_tii=delta*s_ii1+(1-delta)*s_ii2;
num_tij=delta*s_ij1+(1-delta)*s_ij2;
num_tji=delta*s_ji1+(1-delta)*s_ji2;
num_tjj=delta*s_jj1+(1-delta)*s_jj2;

denom_i=delta*r_i1_prime+(1-delta)*theta*r_i2_prime;
denom_j=delta*r_j1_prime+(1-delta)*theta*r_j2_prime;

tii=num_tii/denom_i;
tij=num_tij/denom_i;
tji=num_tji/denom_j;
tjj=num_tjj/denom_j;


%%%%%%%%%%%%Vérification des conditions théoriques d'exclusion%%%%%%%%%
fprintf('=== CONDITIONS MATHÉMATIQUES ===\n');
fprintf('Env1: t_ii1=%.4f > t_ji1=%.4f ? %s\n', s_ii1/r_i1_prime, s_ji1/r_j1_prime, string(s_ii1/r_i1_prime>s_ji1/r_j1_prime));
fprintf('Env2: t_ii2=%.4f > t_ji2=%.4f ? %s\n',s_ii2/r_i2_prime,s_ji2/r_j2_prime,string(s_ii2/r_i2_prime>s_ji2/r_j2_prime));
fprintf('Env. Moyenné: t_jj=%.4f > t_ij=%.4f ? %s\n', tjj, tij, string(tjj>tij));


%%%%%%%données des EDO%%%%%%%
f1=@(t, x) [r_i1_prime*Z1*(1/(1+x(2)))*x(1)-s_ii1*x(1)^2-s_ij1*x(1)*x(2);
            r_j1_prime*Z1*(1/(1+x(1)))*x(2)-s_jj1*x(2)^2-s_ji1*x(1)*x(2)];

f2=@(t, x)[r_i2_prime*Z2*(1/(1+x(2)))*x(1)-s_ii2*x(1)^2-s_ij2*x(1)*x(2);
           r_j2_prime*Z2*(1/(1+x(1)))*x(2)-s_jj2*x(2)^2-s_ji2*x(1)*x(2)];
%%%%%%%%%%%système moyen%%%%%%%%%%%%%
f_avg=@(t, x)[ri*Z1*(1/(1+x(2)))*x(1)-tii*x(1)^2-tij*x(1)*x(2);
              rj*Z1*(1/(1+x(1)))*x(2)-tjj*x(2)^2-tji*x(1)*x(2)];

%%%%%%%%Calcul des équilibre%%%%%%%%
E_i1=[r_i1_prime*Z1/s_ii1, 0];
E_i2=[r_i2_prime *Z2/s_ii2, 0];
E_j_avg=[0, rj*Z1/tjj];

% Choisies de façon à respecter les bassins d'attrations respectifs
ic=[50, 30; 40, 20;50,35;30,25];

%%%%%%%%%tracer%%%%%%%%%%%%%%%%
figure('Position', [100, 100, 1000, 400]);

%%%%%%%%%%% portraits de phase%%%%%%%%%%%%%

subplot(1, 2, 1);
hold on; grid on; box on;
title('a) Env. superposés', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('x_i', 'FontSize', 11);
ylabel('x_j', 'FontSize', 11);
xlim([0, 90]); ylim([0, 90]);

for i= 1:size(ic, 1)
    x0 = ic(i, :);
    
    % Simuler les trois systèmes avec le même ci
    [~, x1] = ode45(f1, [0, 50], x0);
    [~, x2] = ode45(f2, [0, 50], x0);
    [~, x_avg] = ode45(f_avg, [0,50], x0);
    
    % Tracer avec des styles différents
    plot(x1(:,1), x1(:,2), 'r-', 'LineWidth', 1.5);
    plot(x2(:,1), x2(:,2), 'b-', 'LineWidth', 1.5);
    plot(x_avg(:,1), x_avg(:,2), 'g-', 'LineWidth', 2.5);
    %plot(x0(ic_idx,:), 'bo', 'MarkerFaceColor', 'k', 'MarkerSize', 4);
end

legend({'env1', 'env moyen','env2'});

% Ajout des équilibre d'exclusion%%%%%%%%

text(85, 5, 'E_i', 'FontSize', 11, 'Color', 'k', 'FontWeight', 'bold');
text(5, 85, 'E_j', 'FontSize', 11, 'Color', 'k', 'FontWeight', 'bold');

%%%%%%%les Proba d'ACCÈS au ressource%%%%%%%%%% 
subplot(1, 2, 2);
hold on; grid on; box on;
title('b) Prob. d''accès (système moyenné)', 'FontSize', 12);
xlabel('Temps', 'FontSize', 11);
ylabel('1/(1+x)', 'FontSize', 11);
%xlim([0, 70]);
ylim([0, 1.1]);


 x0p=ic(2,:); %%%%%une seule ci%%%%%
[t, x_avg_example]=ode45(f_avg, [0, 1.5], x0p);

% Calcul des probabilités
P_i=1./(1+x_avg_example(:,2)); %%%%%%% accès pour i
P_j=1./(1+x_avg_example(:,1));  %%%%%%% accès pour j

plot(t, P_i, 'b-', 'LineWidth', 2.5, 'DisplayName', '1/(1+x_i)');
plot(t, P_j, 'r-', 'LineWidth', 2.5, 'DisplayName', '1/(1+x_j)');
legend({'1/(1+x_i)', '1/(1+x_j)'});


%%%%%%%%%%%%%byIdyBA%%%%%%%%%%%


