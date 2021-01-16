function outMean = grassmann_mean_proj(X)
%this function computes the mean of a set of points
%{X_i}_{i=1}^{nPoints} on G(p,n).
% X = X(:,:,idx);

[n,p,nPoints] = size(X);
tmpBig = zeros(n,n);
for tmpC1 = 1:nPoints
    tmpBig = tmpBig + X(:,:,tmpC1)*X(:,:,tmpC1)';
end
[outMean,~] = eigs(tmpBig,p);
end