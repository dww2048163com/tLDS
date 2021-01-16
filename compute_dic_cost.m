function cost = compute_dic_cost(X,D,alpha)
[~,p,nPoints] = size(X);
k_DD = p - 0.5*grassmann_proj(D);
k_DX = p - 0.5*grassmann_proj(X,D);
cost = p*nPoints -2*trace(alpha'*k_DX) + trace(alpha'*k_DD*alpha);
end