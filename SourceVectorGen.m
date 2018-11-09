function [F] = SourceVectorGen(mesh, f_scalar, f_linear)
%Generates source vector
%Inputs:
%mesh - Mesh contains local elements and other data in it's structure
%f_scalar - Constant source term
%f_linear - Linear source term multiplier

ne = mesh.ne;   %Number of elements
J = mesh.elem(1).J; %Jacobi (assumed equally spaced mesh)

%% Initalise Source Vector F and add in Scalar Part
F = ones((ne+1),1);     %Initialise Source Vector
%Substitute in the scalar source vector terms
F = (2*f_scalar*J) .* F;    
F(1) = f_scalar*J;     
F(end) = f_scalar*J;



%% Add in the Linear Element Vectors
for eID = 1:ne
    %Caluculat Linear Source Local Element Vectors
    LinearSourceLocal = LinearSourceElemVector(mesh, eID, f_linear);
    %AddLocal Linear Source into Source Vector at correct location
    F(eID:(eID+1)) = F(eID:(eID+1)) + LinearSourceLocal;
end


