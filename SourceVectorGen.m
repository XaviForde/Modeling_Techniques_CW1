function [F] = SourceVectorGen(mesh, f_scalar, f_linear)

ne = mesh.ne;   %number of elements
J = mesh.elem(1).J; %Jacobian (assumed equally spaced mesh)

%% Initalise Scalar Part of Source Vector F and add in scalar part
F = ones((ne+1),1);
F = (2*f_scalar*J) .* F;
F(1) = f_scalar*J;
F(end) = f_scalar*J;

%% Now add in the Linear Element Matrices
for eID = 1:ne
    F(eID:(eID+1)) = F(eID:(eID+1)) + LinearSourceElemMatrix(mesh, eID, f_linear);
end


