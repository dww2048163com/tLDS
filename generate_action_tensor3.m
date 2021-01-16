function action_tensor = generate_action_tensor3(joint_location,body_model)

% joint_location = joint_locations{1};

    action_n_frame = size(joint_location,3);
    action_tensor = zeros(body_model.n_bones,body_model.n_bones,action_n_frame);
    
    for i = 1:action_n_frame
        action_tensor(:,:,i) = generate_posture_matrix(joint_location(:,:,i),body_model);
        
    end