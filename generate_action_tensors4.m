function action_tensors = generate_action_tensors4(joint_locations,body_model)

    action_n = size(joint_locations,1);
    %action_tensors4 = cell(action_n,1);
    action_tensors3 = cell(action_n,1);
    
    for i =1:action_n
        i
        action_tensors3{i} = generate_action_tensor4(joint_locations{i},body_model);
    end
    
  