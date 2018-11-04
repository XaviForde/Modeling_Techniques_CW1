%%%% Part 2: Modelling and Simultion Results
% Use FEM solver to solve k.(d^2T/dx^2) + Q(T_L - t) = 0 
clear
clc
%% Set parameters given in the question
xmin = 0;
xmax = .01;
ne = 100;
k = 1.01e-5;
BC(1).type = "dirichlet";
BC(1).value = 323.15;   %Temperature in Kelvin
BC(2).type = "dirichlet";
BC(2).value = 293.15;       %Temperature in Kelvin
f_linear = 0;

%Set Q as a single value for now
Q = 1;

%Set T_L as a single value for now
T_L = 294.15;
f_scalar = -Q*T_L;

mesh = StaticReactDiffSolver(Q, k, xmin, xmax, ne, f_scalar, f_linear, BC);

x = 0:(xmax/ne):xmax;

figure(1)
plot(x,mesh.c)

%% Second part with linear source term
f_linear = 4*Q*T_L;
mesh = StaticReactDiffSolver(Q, k, xmin, xmax, ne,  f_scalar,f_linear, BC);

figure(2)
plot(x,mesh.c)

