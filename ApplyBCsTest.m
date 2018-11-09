%Testing ApplyBCs.m applies boundary conditions correctly

%% Test 1: Test Dirichlet boundary at xmin sets all but first element of 
% global matrix to zero

D = 1;
lambda = 0;
ne = 6;
f_constant = 0;
xmin = 0;
xmax = 1;
%Create Boundary Condition Stucture
BC(1).type = "dirichlet";
BC(1).value = 2;
BC(2).type = "none";
f_linear = 0;
%Generate Mesh
mesh = OneDimLinearMeshGen(xmin,xmax,ne);
%Generate Global Matrix
GlobalMatrix = GlobalMatrixGen(mesh, D, lambda);
%Generate source vector
F = SourceVectorGen(mesh, f_constant, f_linear);

%Apply Boundary Condition
[GlobalMatrix, F] = ApplyBCs(BC, GlobalMatrix, F, ne);

assert(GlobalMatrix(1,1) ~= 0 && sum(GlobalMatrix(1, 2:end)) ==0) 

%% Test 2: Test for parameters in Test 1 the first source term is equal to
% Boundary Condition value and all other elements are zero

%Check number of non zero elements in F is 1
NumNonZeroF = nnz(F);% Gets number of non zero values in F

assert(F(1) == BC(1).value && NumNonZeroF == 1)

%% Test 3: Test that global matrix is unchanged for two nuemann BCs
D = 2;
lambda = 0;
ne = 8;
f_constant = 1;
xmin = 0;
xmax = 1;
%Create Boundary Condition Stucture
BC(1).type = "neumann";
BC(1).value = 2;
BC(2).type = "nuemann";
f_linear = 0;

%Generate Mesh
mesh = OneDimLinearMeshGen(xmin,xmax,ne);
%Generate Global Matrix
GlobalMatrixIn = GlobalMatrixGen(mesh, D, lambda);
%Generate source vector
F = SourceVectorGen(mesh, f_constant, f_linear);

%Apply the BCs
[GlobalMatrixOut, F] = ApplyBCs(BC, GlobalMatrixIn, F, ne);

assert(isequal(GlobalMatrixOut, GlobalMatrixIn))



