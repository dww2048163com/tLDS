%implemented by Sahar
% use the below codes for decomposition
 A1=[4 1 7;1 10 3; 5 9 2];
B1=[2 2 3 ;2 5 1; 7 1 4];
 C=kron(A1,B1);
[outA,outB]=decomposeKronecker(A1,B1,C)



n=16;

A = randn(n*n,n*n);
A_s = [];

for i=1:n
    for j=1:n
        a = reshape(A((i-1)*n+1:(i-1)*n+n,(j-1)*n+1:(j-1)*n+n),[n*n,1])';
        A_s = [A_s; a];
    end
end

[U,S,V] = svd(A_s,0);

A_n = zeros(n*n,n*n);

for i=1:n
    sigma = sqrt(S(i,i));
    B_v = sigma*U(:,i);
    C_v = sigma*V(:,i);
    B = reshape(B_v,[16,16]);
    C = reshape(C_v,[16,16]);
    A_n = A_n+kron(B,C);    
end

norm(A-A_n)

A_n1'*A_n1

B = randn(16,16);
C = randn(16,16);



    
    