function [mesh] = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f_scalar, f_linear,  BC)
%%% Solves the static reaction diffusion equation
% Inputs:
% lambda - Coefficient for Reaction (scalar)
% D - Coefficient of Diffusion (scalar)
% xmin - Minimum value for x, usually 0(scalar)
% xmax - Maximum value for x, usually 1(scalar)
% ne - Number of Elements in Mesh (scalar)
% f - Source Term (scalar)
% BC - Boundary Conditions (structure)

mesh = OneDimLinearMeshGen(xmin, xmax, ne); %Create Mesh

GlobalMatrix = zeros((ne+1),(ne+1));  %Initiate Global Matrix

%% Generate the source the vector
F = SourceVectorGen(mesh, f_scalar, f_linear);

%% Assemble local element matrices into global matrix
for eID = 1:ne
    
    %Local Element matrix is the sum of the Laplace and Linear Reation
    LocalElementMatrix = LaplaceElemMatrix(D, eID, mesh) ...
                            - LinearReactionElemMatrix(lambda, eID, mesh);
    
    GlobalMatrix(eID:(eID+1),eID:(eID+1)) = GlobalMatrix(eID:(eID+1),eID:(eID+1))...
                                            + LocalElementMatrix;
end

%Apply Boundary Conditions
[GlobalMatrix, F] = ApplyBCs(BC, GlobalMatrix, F, ne);

%% Solve for C
C = GlobalMatrix \ F;

for i = 1:length(C)
    mesh.c(i) = C(i);
end

end
