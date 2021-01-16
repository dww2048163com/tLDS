function Dn = update_dict(X,D,alpha)
sym_mat = @(X) real(0.5*(X+X'));
nAtoms = size(D,3);
[n,p,~] = size(X);
Dn = zeros(size(D));
for r = 1:nAtoms
    S = zeros(n);
    idx_alpha = find(alpha(r,:));
    if (isempty(idx_alpha))
        fprintf('a useless atom identified!\n');
        continue;
    end
    for tmpC1 = 1:length(idx_alpha)
        S = S + alpha(r,idx_alpha(tmpC1))*X(:,:,idx_alpha(tmpC1))*X(:,:,idx_alpha(tmpC1))';
        for j = 1:nAtoms
            if (j == r) || (alpha(j,idx_alpha(tmpC1)) == 0)
                continue;
            end
            S = S - alpha(j,idx_alpha(tmpC1))*alpha(r,idx_alpha(tmpC1))*D(:,:,j)*D(:,:,j)';
        end
    end
    S = sym_mat(S);
    [Dn(:,:,r),~] = eigs(S,p,'LA');
end


end