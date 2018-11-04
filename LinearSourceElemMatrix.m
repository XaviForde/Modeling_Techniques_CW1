function [ElemMatrix] = LinearSourceElemMatrix(mesh, eID, f_linear)

J =mesh.elem(1).J;
x0 = mesh.elem(eID).x(1);
x1 = mesh.elem(eID).x(2);
xMatrix = [x0;x1];
StandardMatrix = [(2/3), (1/3); (1/3), (2/3)];
                    
ElemMatrix = J * f_linear *  StandardMatrix * xMatrix;