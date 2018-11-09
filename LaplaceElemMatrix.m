function [SqMatrix] = LaplaceElemMatrix(D, eID, msh)

%Returns the local 2x2 element matrix of a given element for a given diffusion
%coefficient
%
% Inputs: 
% D - Coefficient of Diffusion
% eID - Index of element within mesh structure
% msh - Mesh which contains local elements within it's structure

%% Form of Laplace Elem matrix for J=1, D=1

SqMatrix = [0.5, -0.5; ...
            -0.5, 0.5];

%% Multiply  by (1/J) and D to get solution for the particular element

J = msh.elem(eID).J;  %Get Jacobi for the element

SqMatrix = (1/J) * D * SqMatrix;   %Local element matrix for element eID
end


