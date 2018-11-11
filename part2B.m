%Part 2b, investigating the linear source term
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

%% Set Q = 1 as other values are exaggerations of the same shape
Q = 1;

%%Plot four graphs at different values of T_L
color = [0.127, 0.0, 0.8];  %set color for the lines
for T_L = 294.15:7:322.15    %
    
    figure() %initiate next figure
    
    %Calculate f_scalar for boundary condition
    f_constant = Q*T_L;
    f_linear = 4*Q*T_L;
    
    %Solve temperature using FEM with no Linear Source
    mesh = StaticReactDiffSolver(k, -Q, xmin, xmax, ne, f_constant, 0, BC);
    plot(mesh.nvec, mesh.c, '--', 'Color', color)
    hold on
    %Now solve including the Linear Source
    mesh = StaticReactDiffSolver(k, -Q, xmin, xmax, ne, f_constant, f_linear, BC);
    plot(mesh.nvec, mesh.c, '-', 'Color', color)
    
    %% Format the figure
    title(strcat('Effect of Linear Source on Temperature Profile, $T_L = ', num2str(T_L), 'K$'), 'interpreter' ,'latex', 'FontSize', 12)
    lgd = legend({'Question 2a', 'Question 2b'},'Location', 'northeast', 'interpreter', 'latex');
    lgd.Title.String = 'Equation';
    xlabel('$x$ \ in \ Metres','interpreter','latex', 'FontSize', 12);
    ylabel('Temperature in Kelvin', 'interpreter','latex', 'FontSize', 12);
    grid on
    %% Saving Figure
    str = strcat("\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsLinear", num2str(floor(T_L)));
    %print(str, '-depsc')
    %% Clear figure
    hold off
end

T_L = 322.15;
figure() %initiate next figure

%Calculate f_scalar for boundary condition
f_constant = Q*T_L;
f_linear = 4*Q*T_L;

%Solve temperature using FEM with no Linear Source
figure()
meshLIN = StaticReactDiffSolver(k, -Q, xmin, xmax, ne, f_constant, f_linear, BC);
dx = (xmax - xmin)/ne;
for i = 2:ne

    dcdxlin(i-1) = meshLIN.c(i) - meshLIN.c(i-1) / dx;
    x(i-1) = (meshLIN.nvec(i) + meshLIN.nvec(i-1)) / 2;
end
plot(x, dcdxlin, 'r--')
xlim([0 0.01])
hold on
meshLIN = StaticReactDiffSolver(k, -Q, xmin, xmax, ne, f_constant, 0, BC);
dx = (xmax - xmin)/ne;
for i = 2:ne

    dcdxlin(i-1) = meshLIN.c(i) - meshLIN.c(i-1) / dx;
    x(i-1) = (meshLIN.nvec(i) + meshLIN.nvec(i-1)) / 2;
end
plot(x, dcdxlin, 'b--')
xlim([0 0.01])
hold on


