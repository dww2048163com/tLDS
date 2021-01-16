function alpha = local_sparse_coding(X,dicX,L)

% dicX = D;
% L = dict_options.L;

[~,p,~] = size(dicX);
% nPoints = size(X,3);

%Creating kernel matrices
K_D = grassmann_proj(dicX);
K_XD = grassmann_proj(X,dicX);


%preparing for vector calculations
[KD_U,KD_D,~] = svd(K_D);
D = diag(sqrt(diag(KD_D)))*KD_U'/sqrt(p);
D_Inv = KD_U*diag(1./sqrt(diag(KD_D)));
qX = D_Inv'*K_XD/sqrt(p);
alpha = full(mexOMP(qX,D,struct('L',L)));

end

