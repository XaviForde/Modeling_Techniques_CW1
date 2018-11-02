function [mesh] = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f, BC0_type,BC0_value, BC1_type, BC1_value)
%%% Solves the static reaction diffusion equation
% Inputs:
% lambda - Coefficient for Reaction (scalar)
% D - Coefficient of Diffusion (scalar)
% xmin - Minimum value for x, usually 0(scalar)
% xmax - Maximum value for x, usually 1(scalar)
% ne - Number of Elements in Mesh (scalar)
% BC0 - Boundary Condition at Start point, "Neumann" or "Dirichlet" (string)
% BC1 - Boundary Condition at End point. "Neumann" or "Dirichlet"(string)
% f - Source Term (scalar)

mesh = OneDimLinearMeshGen(xmin, xmax, ne); %Create Mesh

GlobalMatrix = zeros((ne+1),(ne+1));  %Initiate Global Matrix

%Create source vector
F = ones((ne+1),1);
F = (f/ne) .* F;
F(1) = f/(2*ne);
F(end) = f/(2*ne);

for eID = 1:ne
    
    LocalElementMatrix = LinearReactionElemMatrix(lambda, eID, mesh) ...
                            + LaplaceElemMatrix(D, eID, mesh);
    
    GlobalMatrix(eID:(eID+1),eID:(eID+1)) = GlobalMatrix(eID:(eID+1),eID:(eID+1))...
                                            + LocalElementMatrix;
end


%% Apply Boundary Conditions, will pass if no boundary condition %
% Dirichlet Boundary Conditions
if BC0_type == "Dirichlet"  %x = xmin boundary
   
    GlobalMatrix(1,:) = [1, zeros(1,ne)];
    F(1) = BC0_value;
    
end

if BC1_type == "Dirichlet"  %x = xmax boundary:
   
    GlobalMatrix(end,:) = [zeros(1,ne), 1];
    F(end) = BC1_value;
    
end

% Neumann Boundary Conditions:-
if BC0_type == "Nuemann"    %x = xmin boundary:
    F(1) = F(1) - BC0_value;
end

if BC0_type == "Nuemann"    %x = xmax boundary:
    F(end) = F(end) + BC1_value;
end

%% Solve for C
C = GlobalMatrix \ F;

for i = 1:length(C)
    mesh.c(i) = C(i);
end

end


