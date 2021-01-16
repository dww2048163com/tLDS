
function [outA,outB]=decomposeKronecker(A1,B1,C)
C=triu(C);
A_sym = sym('A', size(A1));
B_sym = sym('B', size(B1));
C_sym=kron(A_sym,B_sym);
C_sym=triu(C_sym);
indx=find(C_sym);
equations=(C_sym(indx)==C(indx));
result=solve( equations);
A = sym('A',size(A1));
A=triu(A);
A_tril_sym=transpose(triu(A,1));
A=A+A_tril_sym;
outA=subs(A,result);
B = sym('B',size(B1));
B=triu(B);
B_tril_sym=transpose(triu(B,1));
B=B+B_tril_sym;
outB=subs(B,result);
kron(outA,outB)
end