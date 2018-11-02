function [SqMatrix] = LaplaceElemMatrix(D, eID, msh)

%Returns a local 2x2 element matrix of a given element for a diffusion
%operator
% Inputs: 
% D - Coefficient of Diffusion
% eID - Index of element within mesh structure
% msh - Mesh which contains local elements within it's structure

%% Local element matrix for J = 1
SqMatrix = zeros(2,2);
SqMatrix(1,1) = 0.5*D;
SqMatrix(1,2) = -0.5*D;
SqMatrix(2,1) = -0.5*D;
SqMatrix(2,2) = 0.5*D;

%% To get local element matrix for this element multiply by dZeta/dx which
%is equivalent to 1/J 

J = msh.elem(eID).J;  %Get Jacobian for the element
SqMatrix = (1/J) .* SqMatrix;   %Local element matrix for element eID

end


