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
Q = 1;
T_L = 308.15;
%% Second part with linear source term
% f_linear = 4*Q*T_L; f_scalar = Q*T_L; %Solve temperature using FEM mesh =
% StaticReactDiffSolver(-Q, k, xmin, xmax, 100, f_scalar, f_linear, BC);
% fig1 = plot(mesh.nvec, mesh.c); xlabel('$x$ \ in \
% Metres','interpreter','latex', 'FontSize', 12); ylabel('Temperature in
% Kelvin', 'interpreter','latex', 'FontSize', 12); title('Temperature
% Distribution with Linear Source Term', 'interpreter' ,'latex',
% 'FontSize', 12)

%%Make some nice graphs
color = [0.127, 0.0, 0.8];
for T_L = floor(294.15:7:322.15)
    
    figure()
    %Vary Q from 0.5 to 1.5 and plot the variation of results
    for Q = 1
        
        %Calculate f_scalar for boundary condition
        f_scalar = Q*T_L;
        f_linear = 4*Q*T_L;
        %Solve temperature using FEM
        
        mesh = StaticReactDiffSolver(-Q, k, xmin, xmax, ne, f_scalar, 0, BC);
        plot(mesh.nvec, mesh.c, '--', 'Color', color)
        hold on
        mesh = StaticReactDiffSolver(-Q, k, xmin, xmax, ne, f_scalar, f_linear, BC);
        plot(mesh.nvec, mesh.c, '-', 'Color', color)
        
        
    end
    
    title(strcat('Effect of Linear Source on Temperature Profile, $T_L = ', num2str(floor(T_L)), '$'), 'interpreter' ,'latex', 'FontSize', 12)
    lgd = legend({'Question 2a', 'Question 2b'},'Location', 'northeast', 'interpreter', 'latex');
    lgd.Title.String = 'Equation';
    %plot([0 0.01] , [T_L T_L], 'LineStyle','--', 'Color', [.17 .17 .17], 'HandleVisibility','off')
    xlabel('$x$ \ in \ Metres','interpreter','latex', 'FontSize', 12);
    ylabel('Temperature in Kelvin', 'interpreter','latex', 'FontSize', 12);
    str = strcat("\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsLinear", num2str(floor(T_L)));
    grid on 
    print(str, '-depsc')
    hold off
end