function [outCost,minIdx] = kmeans_cost(X,centers)
l_dist = grassmann_proj(X,centers);
[minDist,minIdx] = max(l_dist);
outCost = sum(minDist);
end