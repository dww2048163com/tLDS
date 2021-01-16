function [core,CU1,CU2,CU3,CU4,A] = decomposition_action_tensors3(action_tensors, I, J)

%  action_tensors = action_tensors4;

    decomposition_tensors = cell(size(action_tensors,1),1);
    
   
    core = cell(size(action_tensors,1),1);
    CU1 = zeros(I(1),J(1),size(action_tensors,1));
    CU2 = zeros(I(2),J(2),size(action_tensors,1));
    CU3 = zeros(I(3),J(3),size(action_tensors,1));
    CU4 = cell(size(action_tensors,1),1);
    
   A = zeros(J(4),J(4),size(action_tensors,1));
    % A = zeros(J(3),J(3),size(action_tensors,1));
    
    for i =1:size(action_tensors,1)  
        i
        decomposition_tensors{i} = tucker_als(tensor(action_tensors{i}),[J(1),J(2),J(3),J(4)]);
        core{i} = decomposition_tensors{i}.core;
        CU1(:,:,i) = decomposition_tensors{i}.U{1};
        CU2(:,:,i) = decomposition_tensors{i}.U{2};
        CU3(:,:,i) = decomposition_tensors{i}.U{3};
        CU4{i} = decomposition_tensors{i}.U{4};
        D1 = zeros(size(CU4{i},1)); 
        D2 = zeros(size(CU4{i},1));
        D1(2:end,1:end-1) = eye(size(CU4{i},1)-1);
        D2(1:end-1,1:end-1) = eye(size(CU4{i},1)-1);
        A(:,:,i) = (CU4{i}'*D1*CU4{i})/(CU4{i}'*D2*CU4{i});
    end
