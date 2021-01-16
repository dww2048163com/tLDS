function action_tensors_warping = generate_action_tensors4_warping1(core, CU1, CU2, CU3, A, J)
% d = 10

    action_tensors_warping = cell(size(core,1),1);   
    
    for i=1:size(core,1)
        i
        action_obeservation_tensor = zeros(J(1),J(2),J(3),J(4)*J(4));
        X = ttm(core{i},{CU1(:,:,i),CU2(:,:,i),CU3(:,:,i)},[1,2,3]);
        action_obeservation_tensor(:,:,:,1:J(4)) = double(tensor(X));
        for j=2:J(4)
            X = ttm(core{i},{CU1(:,:,i),CU2(:,:,i),CU3(:,:,i),A(:,:,i)^(j-1)});
            action_obeservation_tensor(:,:,:,(j-1)*J(4)+1:j*J(4)) = double(tensor(X));
        end
        action_tensors_warping{i} = action_obeservation_tensor;
    end
    

end