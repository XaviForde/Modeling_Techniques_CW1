%%%THIS SCRIPT TETS A FUNCITON CORRECTLY CALCULATES

%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
tol = 1e-14;
lambda = 2; %diffusion coefficient
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat = LinearReactionElemMatrix(lambda,eID,msh); %THIS IS THE FUNCTION YOU MUST WRITE

assert(abs(elemat(1,2) - elemat(2,1)) <= tol && abs(elemat(1,1) - elemat(2,2))  <= tol, ...
    'Local element matrix is not symmetric!')
%% Test 2: test 2 different elements of the same size produce same matrix
%Test that for two elements of an equispaced mesh, as described in the
%lectures, the element matrices calculated are the same
tol = 1e-14;
lambda = 5; %diffusion coefficient
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat1 = LinearReactionElemMatrix(lambda,eID,msh);	%calculate element 1 matrix

eID=2; %element ID

elemat2 = LinearReactionElemMatrix(lambda,eID,msh); %calculate element 2 matrix

diff = elemat1 - elemat2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)

%% Test 3: test that one matrix is evaluted correctly
% % Test that element 1 of the three element mesh problem described 
% in Tutorial 3 Question 2c has the element matrix evaluated correctly
tol = 1e-14;
lambda = 1; %diffusion coefficient
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,6);

elemat1 = LinearReactionElemMatrix(lambda,eID,msh);%THIS IS THE FUNCTION YOU MUST WRITE

elemat2 = [ (1/18), (1/36); (1/36), (1/18)];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 4: test main diagonal values are double antidiagonal values


