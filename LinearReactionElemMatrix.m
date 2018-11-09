function [SqMatrix] = LinearReactionElemMatrix(lambda, eID, msh)

%Returns a local 2x2 element matrix of a given element for a diffusion
%operator
% Inputs: 
% lambda - Scalar Coefficient of Diffusion
% eID - Index of element within mesh structure
% msh - Mesh which contains local elements within it's structure

%% Form of Linear Reaction local element matrix for J = 1 and lambda = 1
SqMatrix = [(2/3), (1/3); ...
            (1/3), (2/3)];

%% Multiply by J and lambda to get solution for the particular element

J = msh.elem(eID).J;  %Get Jacobi for the element

SqMatrix = J * lambda .* SqMatrix;   %Local Linear Reaction matrix for element eID
end


