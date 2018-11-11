%%%% Part 2a: Modelling and Simultion Results
% Use FEM solver to solve k.(d^2T/dx^2) + Q(T_L - t) = 0
clear
clc
%% Set parameters given in the question
xmin = 0;   %Min x in metres
xmax = .01; % Max x in metres
ne = 70;    %Number of elements
k = 1.01e-5;    % Coefficient of diffusion
%Set Boundary Conditions:
BC(1).type = "dirichlet";
BC(1).value = 323.15;   %Temperature in Kelvin
BC(2).type = "dirichlet";
BC(2).value = 293.15;       %Temperature in Kelvin
%No linear source for part a:
f_linear = 0;

%Initialise counter
i = 1;

%% Create four plots at different T_L values showing the effect of Q
for T_L = 294.15:7:322.15   

    figure(i)
    i = i+1;
    %Vary Q from 0.5 to 1.5 and plot the variation of results
    for Q = 0.5:0.25:1.5

        %Calculate f_scalar for boundary condition
        f_scalar = Q*T_L;
        %Solve temperature using FEM
        mesh = StaticReactDiffSolver(k, -Q, xmin, xmax, ne, f_scalar, f_linear, BC);
        %Plot result
        plot(mesh.nvec, mesh.c)
        hold on

    end
    %Format Figure:
    title(strcat('Temperature Profile at Various Liquid Flow Rates, $T_L = ', num2str(T_L), 'K$'), 'interpreter' ,'latex', 'FontSize', 12)
    lgd = legend({'$Q = 0.50$', '$Q = 0.75$', '$Q = 1.00$', '$Q = 1.25$' , '$Q = 1.50$'},'Location', 'northeast', 'interpreter', 'latex');
    lgd.Title.String = 'Liquid Flow Rate';
    xlabel('$x$ \ in \ Metres ','interpreter','latex', 'FontSize', 12);
    ylabel('Temperature in Kelvin', 'interpreter','latex', 'FontSize', 12);
    %Plot T_L to help with visualisation of the result:
    plot([0 0.01] , [T_L T_L], 'LineStyle','--', 'Color', [.17 .17 .17], 'HandleVisibility','off')
    text(0.002, (T_L + 1), strcat('$T_L = ', num2str(T_L), '$'), 'interpreter', 'latex')
    grid on 
    %Save the figure:
    str = strcat("\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsVaryQ", num2str(floor(T_L)));
    print(str, '-depsc')
    hold off
end

%% Now we vary T_L in the plots for 4 different Q values
i1=0; %new counter for indexing saved results
%Create a plot for each value of Q
for Q = 0.5:0.25:1.5

    i1 = i1+1;
    figure()
    %Vary T_L and plot the variation of results
    for T_L = 294.15:7:322.15

        %Calculate f_scalar for boundary condition
        f_scalar = Q*T_L;
        disp(f_scalar)
        %Solve temperature using FEM
        mesh = StaticReactDiffSolver(k, -Q, xmin, xmax, ne, f_scalar, f_linear, BC);
        %Plot the results
        plot(mesh.nvec, mesh.c)
        hold on

    end
    %Format the Figure:
    title(strcat('Temperature Profile at Various Liquid Temperatures, $Q = ', num2str(Q), '$'), 'interpreter' ,'latex', 'FontSize', 12)
    lgd = legend({'$T_L = 294.15$', '$T_L = 301.15$', '$T_L = 308.15$', '$T_L = 315.15$' , '$T_L = 322.15$'},'Location', 'northeast', 'interpreter', 'latex');
    lgd.Title.String = 'Liquid Temp in K';
    xlabel('$x$ \ in \ Metres ','interpreter','latex', 'FontSize', 12);
    ylabel('Temperature in Kelvin', 'interpreter','latex', 'FontSize', 12);
    grid on
    %Save the Figure
    str = strcat("\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsVaryTL", num2str(i1));
    print(str, '-depsc')
    hold off
end

%% Investigate the effect of Mesh size
figure()
ne = [10, 25, 35, 50, 70];  %Range of Mesh sizes to investigate

for i = 1:length(ne)
    Q = 1.5;    %Choose extreme Q value
    T_L = 294.15;   %Choose extreme T_L value
    %Calculate f_scalar for boundary condition
    f_scalar = Q*T_L;
    %Solve temperature using FEM
    mesh = StaticReactDiffSolver(k, -Q, xmin, xmax, ne(i), f_scalar, f_linear, BC);
    %Plot the result
    fig1 = plot(mesh.nvec, mesh.c);
    hold on
    
end
%Format the Figure
xlabel('$x$ \ in \ Metres','interpreter','latex', 'FontSize', 12);
ylabel('Temperature in Kelvin', 'interpreter','latex', 'FontSize', 12);
title('Comparing Mesh Sizes', 'interpreter' ,'latex', 'FontSize', 12)
lgd = legend({num2str(ne(1)), num2str(ne(2)), num2str(ne(3)) , num2str(ne(4)), num2str(ne(5))}, 'interpreter', 'latex', 'Location', 'northeast');
lgd.Title.String = 'Number Of Elements';
grid on 
%Save the Figure
print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsMesh01'

%Zoom in on a point where meshes have converged
xlim([1.414e-3 1.416e-3]);
ylim([310.92 310.97]);
yticks(310.92:.005:310.97)
grid on 
%Save the Figure
print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsMesh11'

%Zoom in on point where meshes are close to maximum diverence
xlim([1.556e-3 1.563e-3]);
ylim([310 310.05]);
yticks(310:.005:310.05);
grid on 
%Save the Figure
print -depsc '\Users\xav_m\OneDrive\Documents\XAVI\University\Final Year\Systems Mod\Modeling_Techniques_CW1\Report\Figures\epsMesh12'


