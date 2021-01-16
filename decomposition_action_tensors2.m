function [core,CU1,CU2,CU3,CU4,A] = decomposition_action_tensors2(action_tensors, I, J)

%  action_tensors = action_tensors4;
 
   
    core = cell(size(action_tensors,1),1);
    CU1 = zeros(I(1),J(1),size(action_tensors,1));
    CU2 = zeros(I(2),J(2),size(action_tensors,1));
    CU3 = zeros(I(3),J(3),size(action_tensors,1));
    CU4 = cell(size(action_tensors,1),1);
    
    A = zeros(J(4),J(4),size(action_tensors,1));
    
    for i =1:size(action_tensors,1)  
        i        
        CU1(:,:,i) = nvecs(tensor(action_tensors{i}),1,J(1)); %<-- Mode 1
        CU2(:,:,i) = nvecs(tensor(action_tensors{i}),2,J(2)); %<-- Mode 2
        CU3(:,:,i) = nvecs(tensor(action_tensors{i}),3,J(3)); %<-- Mode 3
        CU4{i} = nvecs(tensor(action_tensors{i}),4,J(4));
        core{i} = ttm(tensor(action_tensors{i}),{pinv(CU1(:,:,i)),pinv(CU2(:,:,i)),pinv(CU3(:,:,i)),pinv(CU4{i})}); %<-- Core
        D1 = zeros(size(CU4{i},1)); 
        D2 = zeros(size(CU4{i},1));
        D1(2:end,1:end-1) = eye(size(CU4{i},1)-1);
        D2(1:end-1,1:end-1) = eye(size(CU4{i},1)-1);
        A(:,:,i) = (CU4{i}'*D1*CU4{i})/(CU4{i}'*D2*CU4{i});         
    end
