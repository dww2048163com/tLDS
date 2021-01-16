function action_tensors = generate_action_tensors3(joint_locations,body_model)

    action_n = size(joint_locations,1);
    action_tensors = cell(action_n,1);
    
    for i =1:action_n
        i
        action_tensors{i} = generate_action_tensor3(joint_locations{i},body_model);
    end