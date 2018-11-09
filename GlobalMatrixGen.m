function [GlobalMatrix] = GlobalMatrixGen(mesh, D, lambda)
%Returns Global Matrix of Difusion and Reaction terms
% Inputs:
% lambda - Coefficient for Reaction (float ot int)
% D - Coefficient of Diffusion (float or int)


%% Initiate Global Matrix
ne = mesh.ne;       %Number of Elements
GlobalMatrix = zeros((ne+1),(ne+1));  
%% Loop over Elements and Assemble Local Element Matrices into Global Matrix
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