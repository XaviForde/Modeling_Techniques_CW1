function [mesh] = StaticReactDiffSolver(D, lambda, xmin, xmax, ne,f_constant, f_linear,  BC)
%%% Solves the static diffusion-reaction equation
% Inputs:
% lambda - Coefficient for Reaction (float ot int)
% D - Coefficient of Diffusion (float or int)
% xmin - Minimum value for x, usually 0(float or int)
% xmax - Maximum value for x, usually 1(float or int)
% ne - Number of Elements in Mesh (float)
% f_constant - Constant Source Term (float or int)
% f_linear - Linear Source Term (float or int)
%BC - Structure which contains the following:
%       BC(1) - Holds data for minimum x boundary
%       BC(2) - Holds data for maximum x boundary
%       BC().type - Type of boundary condition: "neumann", "dirichlet" or
%                   "none" (must be a lower case string)
%       BC().value - Value of the boundary condition (float or int)

mesh = OneDimLinearMeshGen(xmin, xmax, ne); %Generate Mesh

%% Generate the Global Matrix for Diffusion and Reaction terms
GlobalMatrix = GlobalMatrixGen(mesh, D, lambda);

%% Generate the Global source the vector
F = SourceVectorGen(mesh, f_constant, f_linear);

%% Apply Boundary Conditions to the Global Matrix and Global Source Vector
[GlobalMatrix, F] = ApplyBCs(BC, GlobalMatrix, F, ne);

%% Solve for C
C = GlobalMatrix \ F;       %Returns a vector of C values

%Add values of C into the mesh structure
mesh.c = C;

end
