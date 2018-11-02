function [SqMatrix] = LinearReactionElemMatrix(lambda, eID, msh)

%Returns a local 2x2 element matrix of a given element for a diffusion
%operator
% Inputs: 
% lambda - Scalar Coefficient of Diffusion
% eID - Index of element within mesh structure
% msh - Mesh which contains local elements within it's structure

%% Local element matrix for J = 1
SqMatrix = zeros(2,2);
SqMatrix(1,1) = (2/3)*lambda;
SqMatrix(1,2) = (1/3)*lambda;
SqMatrix(2,1) = (1/3)*lambda;
SqMatrix(2,2) = (2/3)*lambda;

%% To get local element matrix for this element multiply by Jacobian

J = msh.elem(eID).J;  %Get Jacobian for the element
SqMatrix = J .* SqMatrix;   %Local element matrix for element eID

end


