function [F] = SourceVectorGen(mesh, f_constant, f_linear)
%Generates source vector
%Inputs:
%mesh - Mesh contains local elements and other data in it's structure
%f_constant - Constant source term
%f_linear - Linear source term multiplier

ne = mesh.ne;   %Number of elements

%% Initalise Gloabal Source Vector F
F = zeros((ne+1),1);     %Initialise Source Vector

%% Add in the Constant and Linear Element Vectors and Add to F
for eID = 1:ne
    
    %Caluculate Constant Source Local Element Vectors
    LocalConstantSource = ConstantSourceElemVector(mesh, eID, f_constant);
    %Caluculate Linear Source Local Element Vectors
    LocalLinearSource = LinearSourceElemVector(mesh, eID, f_linear);
    
    %Add Linear and Constant Vectors to get Local Source Vector
    LocalSourceVector = LocalLinearSource + LocalConstantSource;
    
    %Add Local Source Vector into Global Source Vector at correct location
    F(eID:(eID+1)) = F(eID:(eID+1)) + LocalSourceVector;
end


