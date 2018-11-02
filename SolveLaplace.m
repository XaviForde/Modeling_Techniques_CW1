%%% Solves Laplace equation using FEM

%% Set Variables

D = 1;
lambda = 0;
ne = 4;
f = 0;
xmin = 0;
xmax = 1;
BC0_type = "Dirichlet";
BC0_value = 2;
BC1_type = "Dirichlet";
BC1_value = 0;

mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC0_type,BC0_value, BC1_type, BC1_value);

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

xlim(0,1);
ylim(0,2.5)
%% Now solve with Neumann at x = 0 (Top of page 3)
%Nuemann Condition
BC0_type = "Nuemann";
BC0_value = 2;
%Solve for new boundary condition
mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC0_type,BC0_value, BC1_type, BC1_value);

figure(2)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')
plot(mesh.nvec, mesh.c, '-o')

%% Now check reation terms are solved correctly

lambda = 9;
BC0_type = "Dirichlet";
BC0_value = 0;
BC1_value = 1;

mesh = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC0_type,BC0_value, BC1_type, BC1_value);

%Analytical solution
for i = 1:length(xvec)
    c(i) = (exp(3)/(exp(6)-1)) * (exp(3*xvec(i)) - exp(-3*xvec(i)));
end
%Plot the results of FEM and analytical
figure(3)
%figure('Name', 'Laplace''s Equation with Nuemann at x=0')
plot(mesh.nvec, mesh.c, '-o')
grid on
hold on
plot(xvec, c, 'x')
