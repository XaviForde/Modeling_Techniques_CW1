%%% Solves Laplace equation using FEM
clear
clc
%% Set Variables

D = 1;
lambda = 0;
ne = 4;
f_scalar = 0;
xmin = 0;
xmax = 1;
%Create Boundary Condition Stucture
BC(1).type = "dirichlet";
BC(1).value = 2;
BC(2).type = "dirichlet";
BC(2).value = 0;
f_linear = 0;

%Solve
mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne, f_linear, f_scalar, BC);

xvec = 0:0.25:1;
c = zeros(length(xvec),1);
for i = 1:length(xvec)
    c(i) = 2*(1-xvec(i));
end

figure(1)
LaplaceFig = plot(xvec, c, '-b',mesh.nvec, mesh.c, 'ro');
grid on
title('Laplace Equation $\frac{\partial^2 c}{\partial x^2} = 0$', 'interpreter' ,'latex', 'FontSize', 12)
xlim([0 1]);
ylim([0 2.5]);
ylabel('c ', 'interpreter','latex', 'FontSize', 12);
xlabel('0 $\leq x  \leq$ 1','interpreter','latex', 'FontSize', 12);
legend({'Analytical','FEM'}, 'Interpreter', 'latex')
xticks(0:.25:1)
%print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsLaplaceFig1'

%Calculate error In FEM model
error = zeros(ne+1,1);
for i = 1:(ne+1)
    error(i) = sqrt((c(i) - mesh.c(i))^2);
end
error_rms = sum(error) / length(error);
disp(error_rms)
%% Now solve with Neumann at x = 0 (Top of page 3)
%Nuemann Condition
BC(1).type = "nuemann";
BC(1).value = 2;
BC(2).type = "dirichlet";
BC(2).value = 0;
%Solve for new boundary condition
mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne, f_linear, f_scalar, BC);

figure(2)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')
LaplaceFig2 = plot(mesh.nvec, mesh.c, '-x');
title('Laplace Equation with Neumann Boundary at $x = 0$', 'interpreter' ,'latex', 'FontSize', 12)
grid on
xticks(0:.25:1)
xlabel('0 $\leq x  \leq$ 1','interpreter','latex', 'FontSize', 12);
ylabel('c ', 'interpreter','latex', 'FontSize', 12);
ylim([-2.5 0]);
print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsLaplaceFig2'


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
    mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne, f_linear, f_scalar, BC);
    plot(mesh.nvec, mesh.c, '--')
    hold on
end
title('Diffusion-Reaction Equation: $\frac{\partial^2 c}{\partial x^2} -9c = 0$', 'interpreter' ,'latex', 'FontSize', 12)
lgd = legend('Analytical', num2str(elem_range(1)), num2str(elem_range(2)), num2str(elem_range(3)) , num2str(elem_range(4)), 'Location', 'southeast');
lgd.Title.String = 'Number Of Elements';
xlabel('0 $\leq x  \leq$ 1','interpreter','latex', 'FontSize', 12);
ylabel('c ', 'interpreter','latex', 'FontSize', 12);
print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsReactDiff1'
hold off