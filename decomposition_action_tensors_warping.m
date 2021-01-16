function [CU1,CU2,CU3,CU4,CU5] = decomposition_action_tensors_warping(action_tensors, I, J)

%  action_tensors = action_tensors_warping;

   
   
    CU1 = zeros(I(1),J(1),size(action_tensors,1));
    CU2 = zeros(I(2),J(2),size(action_tensors,1));
    CU3 = zeros(I(3),J(3),size(action_tensors,1));
    CU4 = zeros(I(4),J(4),size(action_tensors,1));
    CU5 = zeros(I(5),J(5),size(action_tensors,1));
    
   
    for i =1:size(action_tensors,1)  
         i
%         decomposition_tensors{i} = tucker_als(tensor(action_tensors{i}),[J(1),J(2),J(3),J(4),J(5)]);
%         core{i} = decomposition_tensors{i}.core;
%         CU1(:,:,i) = decomposition_tensors{i}.U{1};
%         CU2(:,:,i) = decomposition_tensors{i}.U{2};
%         CU3(:,:,i) = decomposition_tensors{i}.U{3};
%         CU4(:,:,i) = decomposition_tensors{i}.U{4};
%         CU5(:,:,i) = decomposition_tensors{i}.U{5};   
          CU1(:,:,i) = nvecs(tensor(action_tensors{i}),1,J(1)); %<-- Mode 1
          CU2(:,:,i) = nvecs(tensor(action_tensors{i}),2,J(2)); %<-- Mode 2
          CU3(:,:,i) = nvecs(tensor(action_tensors{i}),3,J(3)); %<-- Mode 3
          CU4(:,:,i) = nvecs(tensor(action_tensors{i}),4,J(4)); %<-- Mode 4
          CU5(:,:,i) = nvecs(tensor(action_tensors{i}),5,J(5)); %<-- Mode 5
        
    end
