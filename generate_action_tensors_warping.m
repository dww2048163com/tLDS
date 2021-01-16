function action_tensors_warping = generate_action_tensors_warping(core, CU1, CU2, A,d)


    action_tensors_warping = cell(size(core,1),1);
    
    for i=1:size(core,1)
        action_obeservation_matrix = zeros(19,19,d*size(A,1));
        for j=1:d
            X = ttensor(core{i},CU1(:,:,i),CU2(:,:,i),A(:,:,i)^j);
            X = double(tensor(X));
            action_obeservation_matrix(:,:,(size(A,1)*(j-1)+1):size(A,1)*j) = X;
        end
        action_tensors_warping{i} = action_obeservation_matrix;
    end
    

end