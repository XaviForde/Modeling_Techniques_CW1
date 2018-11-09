function [mesh] = StaticReactDiffSolver(lambda, D, xmin, xmax, ne,f_scalar, f_linear,  BC)
%%% Solves the static reaction diffusion equation
% Inputs:
% lambda - Coefficient for Reaction (float ot int)
% D - Coefficient of Diffusion (float or int)
% xmin - Minimum value for x, usually 0(float or int)
% xmax - Maximum value for x, usually 1(float or int)
% ne - Number of Elements in Mesh (float)
% f_scalar - Constant Source Term (float or int)
% f_linear - Linear Source Term (float or int)
%BC - Structure which contains the following:
%       BC(1) - Holds data for minimum x boundary
%       BC(2) - Holds data for maximum x boundary
%       BC().type - Type of boundary condition: "neumann", "dirichlet" or
%                   "none" (must be a lower case string)
%       BC().value - Value of the boundary condition (float or int)

mesh = OneDimLinearMeshGen(xmin, xmax, ne); %Generate Mesh

GlobalMatrix = zeros((ne+1),(ne+1));  %Initiate Global Matrix

%% Generate the source the vector
F = SourceVectorGen(mesh, f_scalar, f_linear);

%% Assemble local element matrices into global matrix
for eID = 1:ne
    
    %Calculate Local Element Matrix for Diffusion Term
    DiffusionLocal = LaplaceElemMatrix(D, eID, mesh);

    %Calculate Local Element Matrix for Linear Reaction Term
    ReactionLocal = LinearReactionElemMatrix(lambda, eID, mesh);
    
    %Local Element Matrix is the Diffusion subtract the Linear Reation
    LocalElementMatrix = DiffusionLocal - ReactionLocal;
                        
    %Add Local Element Matrix into the correct location within the Global Matrix
    GlobalMatrix(eID:(eID+1),eID:(eID+1)) = GlobalMatrix(eID:(eID+1),eID:(eID+1))...
                                            + LocalElementMatrix;
end

%% Apply Boundary Conditions
[GlobalMatrix, F] = ApplyBCs(BC, GlobalMatrix, F, ne);

%% Solve for C
C = GlobalMatrix \ F;

%Add values of C into the mesh structure
for i = 1:length(C)
    mesh.c(i) = C(i);
end

end
