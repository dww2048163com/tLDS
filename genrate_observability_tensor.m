function Y = genrate_observability_tensor(action_tensors_warping,A,X,I,d)
    
   
    Y = cell(size(X,1),1);
    
    for i=1:size(X,1)
        C = tensor(action_tensors_warping{i}(:,:,:,:,1));
        Y0 = zeros(I(1),I(2),I(3),d);
        Y0(:,:,:,1) = ttm(C,X(i,:),4);
        for j =2:d
            CA = ttm(C,A(:,:,i)^(j-1),4);
            Y0(:,:,:,j) = ttm(CA,X(i,:),4);
        end
        Y{i} = Y0;
    end

end
