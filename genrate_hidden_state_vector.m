function [X] = genrate_hidden_state_vector(action_tensors4, action_tensors_warping,A,J)
    
%  action_tensors = action_tensors_warping;
   
    X = zeros(size(action_tensors_warping,1),J(4));    
     
    for i = 1:size(action_tensors_warping,1)
        C = tensor(action_tensors_warping{i}(:,:,:,:,1));
        X0 = rand(1,J(4));
        Y = ttm(C,X0,4);
        Y(:,:,:,1) = tensor(action_tensors4{i}(:,:,:,1));
        CM = tenmat(C,4);
        YM = tenmat(Y,4);
        X(i,:) = double(YM)*pinv(double(CM));
    end
    
   

   
