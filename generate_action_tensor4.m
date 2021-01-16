function  action_tensor3 = generate_action_tensor4(joint_location,body_model)

% joint_location = joint_locations{1};

    action_n_frame = size(joint_location,3);
   % action_tensor4 = zeros(body_model.n_bones,body_model.n_bones,6,action_n_frame);
    action_tensor3 = zeros(body_model.n_bones*(body_model.n_bones-1),5,action_n_frame);
    
    for i = 1:action_n_frame
        %action_tensor4(:,:,:,i) = generate_posture_tensor(joint_location(:,:,i),body_model);
        action_tensor3(:,:,i) = generate_posture_tensor3(joint_location(:,:,i),body_model);
    end