function [ElemVector] = ConstantSourceElemVector(mesh, eID, f_constant)
% Returns the Local Constant Source Vector for an element
%
% Inputs:
% mesh - Mesh which contains local elements within it's structure and
%           related variables
% eID - index for the element within the mesh
% f_const - Constant source term 

J =mesh.elem(eID).J;        %Get Jacobi for the element

ElemVector = [f_constant*J; f_constant*J];  %each term is fJ

end
