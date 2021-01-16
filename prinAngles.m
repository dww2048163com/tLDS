function [C,angles] = prinAngles(A,B)
[Qa,Ra] = qr(A,0);
[Qb,Rb] = qr(B,0);
C = svd(Qa¡¯*Qb,0);
angles = acos(C);