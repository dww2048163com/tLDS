function [X,A,K,C,E] = canonical_realization(Y,n)
tau = size(Y,2);
Y1 = Y(:,1:tau-1);
Y2 = Y(:,2:tau);
Lf = chol(1/(tau - 1)*Y2*Y2')';
Lp = chol(1/(tau - 1)*Y1*Y1')';
[U,S,V] = svd(1/(tau -1)*inv(Lf)*Y2*(Y1')*inv(Lp'));
Un = U(:,1:n);
Vn = V(:,1:n);
Sn = S(1:n,1:n);
Sn_sqrt = diag(sqrt(diag(Sn)));
C = Lf*Un*Sn_sqrt;
X = Sn_sqrt*Vn'*inv(Lp)*Y;
X1 = X(:,1:tau-1);
X2 = X(:,2:tau);
A = 1/(tau - 1)*X2*(X1')*diag(1./diag(Sn));
E = Y - C*X;
K = (X2-A*X1)*pinv(E(:,1:tau-1));