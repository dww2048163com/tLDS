function centers = kmeans_projection(X,k,nIter,verbatim_flag)
% Initializations
% k = nAtoms;
% nIter = 5;
% verbatim_flag = false;


MinCostVariation = 1e-3;

nPoints = size(X,3);

randVal = randperm(nPoints);
centers = X(:,:,randVal(1:k));
for iter = 1:nIter
    fprintf('.');
    %assign points and compute the cost
    [currCost,minIdx] = kmeans_cost(X,centers);
    for tmpC1 = 1:k
        idx = find(minIdx == tmpC1);
        if (isempty(idx))
            %zombie centers
            randVal = randperm(nPoints);
            centers(:,:,tmpC1) = X(:,:,randVal(1));
        else
            centers(:,:,tmpC1) = grassmann_mean_proj(X(:,:,idx));
        end
    end
    if (iter == 1)
        if (verbatim_flag)
            fprintf('kmeans: initial cost is %6.1f.\n',currCost);
        end
    else
        cost_diff = norm(preCost - currCost) ;
        if (cost_diff < MinCostVariation)
            if (verbatim_flag)
                fprintf('kmeans: done after %d iterations due to small relative variations in cost.\n',iter);
            end
            break ;
        elseif (verbatim_flag)
            fprintf('kmeans: Iter#%d, cost is %6.1f.\n',iter,currCost);
        end
    end
    preCost = currCost;
end
fprintf('\n');

end