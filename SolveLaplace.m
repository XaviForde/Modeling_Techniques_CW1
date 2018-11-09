%%% Generate Results for Part 1 Qustions
clear
clc

%% Question 1c - Solving Laplaces Equation:
%% Set Parameter from the question
D = 1;      %Coefficient of Diffusion
lambda = 0; %Coefficient of Reaction
ne = 4;     %Number of elements
f_constant = 0; %No source
f_linear = 0;   %No source
xmin = 0;       %Set x domain from x=0 to x=1
xmax = 1;
%Create Boundary Condition Stucture
BC(1).type = "dirichlet";
BC(1).value = 2;
BC(2).type = "dirichlet";
BC(2).value = 0;

%Use the FEM to obtain a solution for C, solution stored as mesh.c
mesh = StaticReactDiffSolver(D, lambda, xmin, xmax, ne, f_linear, f_constant, BC);

%Create plot points for analytical solution
xvec = 0:0.25:1;        %Same number of nodes/points as FEM method
c = zeros(length(xvec),1);  %Initialise C
% Use the equation given in the question to calculate c values
for i = 1:length(xvec)
    c(i) = 2*(1-xvec(i));
end

%Plot the results
figure()
plot(xvec, c, '-xb',mesh.nvec, mesh.c, 'ro');
grid on
title('Laplace Equation $\frac{\partial^2 c}{\partial x^2} = 0$', 'interpreter' ,'latex', 'FontSize', 12)
xlim([0 1]);
ylim([0 2.5]);
ylabel('c ', 'interpreter','latex', 'FontSize', 12);
xlabel('0 $\leq x  \leq$ 1','interpreter','latex', 'FontSize', 12);
legend({'Analytical','FEM'}, 'Interpreter', 'latex')
xticks(0:.25:1)
%print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsLaplaceFig1'


%% Now solve with Neumann at x = 0 (Top of page 3)
%Nuemann Condition
BC(1).type = "nuemann";
BC(1).value = 2;
BC(2).type = "dirichlet";
BC(2).value = 0;
%Solve for new boundary condition
mesh = StaticReactDiffSolver(D, lambda, xmin, xmax, ne, f_linear, f_constant, BC);

figure(2)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')
LaplaceFig2 = plot(mesh.nvec, mesh.c, '-x');
title('Laplace Equation with Neumann Boundary at $x = 0$', 'interpreter' ,'latex', 'FontSize', 12)
grid on
xticks(0:.25:1)
xlabel('0 $\leq x  \leq$ 1','interpreter','latex', 'FontSize', 12);
ylabel('c ', 'interpreter','latex', 'FontSize', 12);
ylim([-2.5 0]);
%print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsLaplaceFig2'


%% Now check reation terms are solved correctly (bottom of page 3)
D = 1;
lambda = -9;
BC(1).type = "dirichlet";
BC(1).value = 0;
BC(2).type = "dirichlet";
BC(2).value = 1;


%Analytical solution
xvec = 0:(1/100):1;
for i = 1:length(xvec)
    c(i) = (exp(3)/(exp(6)-1)) * (exp(3*xvec(i)) - exp(-3*xvec(i)));
end
%Plot the results of FEM and analytical
figure(3)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')

grid on
hold on
plot(xvec, c, '-b', 'LineWidth', .5)
elem_range = [3,5,10,25];
for i = 1:length(elem_range)
    ne = elem_range(i);
    mesh = StaticReactDiffSolver(D, lambda, xmin, xmax, ne, f_linear, f_constant, BC);
    plot(mesh.nvec, mesh.c, '--')
    hold on
end
title('Diffusion-Reaction Equation: $\frac{\partial^2 c}{\partial x^2} -9c = 0$', 'interpreter' ,'latex', 'FontSize', 12)
lgd = legend('Analytical', num2str(elem_range(1)), num2str(elem_range(2)), num2str(elem_range(3)) , num2str(elem_range(4)), 'Location', 'southeast');
lgd.Title.String = 'Number Of Elements';
xlabel('0 $\leq x  \leq$ 1','interpreter','latex', 'FontSize', 12);
ylabel('c ', 'interpreter','latex', 'FontSize', 12);
%print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsReactDiff1'
hold off