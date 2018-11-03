function [GlobalMatrix, F] = ApplyBCs(BC, GlobalMatrix, F, ne)
% Will apply boundary condition to F and Global Matrix as appropriate
% for the specified boundary condition

%% Solve xmin Boundary Condition 
if BC(1).type == "none" %No action needed if no boundary condition
    % pass 
    
elseif BC(1).type == "dirichlet"  %solve for a dirichlet BC
    GlobalMatrix(1,:) = [1, zeros(1,ne)];
    F(1) = BC(1).value;
    
elseif  BC(1).type == "nuemann"    %solve for a nuemann BC
    F(1) = F(1) - BC(1).value;
end

%% Solve xmax Boundary Condition
if BC(2).type == "none"
    % pass
elseif BC(2).type == "dirichlet"  %solve for dirichlet BC
    
    GlobalMatrix(end,:) = [zeros(1,ne), 1];
    F(end) = BC(2).value;
    
elseif BC(2).type == "nuemann"    %solve nuemann BC
    F(end) = F(end) + BC(2).value;
end   




