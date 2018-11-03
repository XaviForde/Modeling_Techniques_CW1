%%% Solves Laplace equation using FEM
clear
clc
%% Set Variables

D = 1;
lambda = 0;
ne = 4;
f = 0;
xmin = 0;
xmax = 1;
%Create Boundary Condition Stucture
BC(1).type = "dirichlet";
BC(1).value = 2;
BC(2).type = "dirichlet";
BC(2).value = 0;

mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC);

xvec = 0:0.25:1;
c = zeros(length(xvec),1);
for i = 1:length(xvec)
    c(i) = 2*(1-xvec(i));
end

figure(1)
LaplaceFig = plot(mesh.nvec, mesh.c, '-o');
grid on
title('Laplace Equation $\frac{\partial^2 c}{\partial x^2} = 0$', 'interpreter' ,'latex', 'FontSize', 15)
hold on
plot(xvec, c, 'x')
xlim([0 1]);
ylim([0 2.5])
%% Now solve with Neumann at x = 0 (Top of page 3)
%Nuemann Condition
BC(1).type = "nuemann";
BC(1).value = 2;
BC(2).type = "dirichlet";
BC(2).value = 0;
%Solve for new boundary condition
mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC);

figure(2)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')
plot(mesh.nvec, mesh.c, '-o')

%% Now check reation terms are solved correctly (bottom of page 3)
D = 1;
lambda = 9;
BC(1).type = "dirichlet";
BC(1).value = 0;
BC(2).type = "dirichlet";
BC(2).value = 1;
mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC);

%Analytical solution
for i = 1:length(xvec)
    c(i) = (exp(3)/(exp(6)-1)) * (exp(3*xvec(i)) - exp(-3*xvec(i)));
end
%Plot the results of FEM and analytical
figure(3)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')
plot(mesh.nvec, mesh.c, 'g-o')
grid on
hold on
plot(xvec, c, 'kx')
