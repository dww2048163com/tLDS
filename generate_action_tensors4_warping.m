function action_tensors_warping = generate_action_tensors4_warping(core, CU1, CU2, CU3, A, J)
% d = 10

    action_tensors_warping = cell(size(core,1),1);
    a = size(A,1);
    
    for i=1:size(core,1)
        i
        action_obeservation_tensor = zeros(J(1),J(2),J(3),a);
        X = ttm(core{i},{CU1(:,:,i),CU2(:,:,i),CU3(:,:,i)},[1,2,3]);
        action_obeservation_tensor(:,:,:,:,1) = double(tensor(X));
        for j=2:a
            X = ttm(core{i},{CU1(:,:,i),CU2(:,:,i),CU3(:,:,i),A(:,:,i)^(j-1)});
            action_obeservation_tensor(:,:,:,:,j) = double(tensor(X));
        end
        action_tensors_warping{i} = action_obeservation_tensor;
    end
    

end