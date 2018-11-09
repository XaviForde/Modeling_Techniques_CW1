%Testing GlobalMatrixGen.m creates global matrix correctly

%% Test 1: test correct number of elements are non zero
% formula for number of non zeros is 3(n+1) - 2

ne = 24;    %number of mesh elements
mesh = OneDimLinearMeshGen(0,1,ne); %Generate 20 element mesh

%Calculate Analytical number of zeros
AnNumNonZeros = 3*(ne+1) - 2;
%Set Arbitary values for D and lambda
D = 3;
lambda = 5.4;
GlobalMatrix = GlobalMatrixGen(mesh, D, lambda);
NumNonZeros = nnz(GlobalMatrix); %sum index to get number of zero elements

assert( NumNonZeros == AnNumNonZeros);

%% Test 2: Check first two elements of the first row are the same as the 
% last two elements of the last row
tol = 1e-14;
mesh = OneDimLinearMeshGen(0,1,10); %Generate 10 element mesh
%Set Arbitary values for D and lambda
D = 3;
lambda = 5.4;
%Generate global matrix
GlobalMatrix = GlobalMatrixGen(mesh, D, lambda);

%Get first row first two elements
FirstRowValues = GlobalMatrix(1,1:2);
%Get last row last two elements
LastRowValues = GlobalMatrix(end,(end-1):end);
%Subrtact elements and sum to get total difference
diff = sum(FirstRowValues - LastRowValues);

assert(abs(diff) < tol) 

%% Test 3: Check non zero values of any two rows are the same as the 
% excluding first and last row
tol = 1e-14;
mesh = OneDimLinearMeshGen(0,1,10); %Generate 10 element mesh
%Set Arbitary values for D and lambda
D = 3;
lambda = 5.4;
%Generate global matrix
GlobalMatrix = GlobalMatrixGen(mesh, D, lambda);

%Get third row non zero elements
ThirdRowValues = GlobalMatrix(3,3:6);
%Get fith row non zero elements
FithRowValues = GlobalMatrix(5,5:8);
%Subrtact elements and sum to get total difference
diff = sum(ThirdRowValues - FithRowValues);

assert(abs(diff) < tol)

