function [CU1,CU2,CU3,CU4] = decomposition_action_tensors4_warping(action_tensors,I)

    CU1 = zeros(I(2)*I(3)*I(4),I(1),size(action_tensors,1));
    CU2 = zeros(I(1)*I(3)*I(4),I(2),size(action_tensors,1));
    CU3 = zeros(I(1)*I(2)*I(4),I(3),size(action_tensors,1));
    CU4 = zeros(I(1)*I(2)*I(3),I(4),size(action_tensors,1));
    
    for i =1:size(action_tensors,1)  
        i       
        [CU1(:,:,i),CU2(:,:,i),CU3(:,:,i),CU4(:,:,i)] = generate_column_eig_matrix(action_tensors{i});       
    end
