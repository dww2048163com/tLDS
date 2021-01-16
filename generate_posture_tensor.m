function posture_tensor = generate_posture_tensor(posture_joint,body_model)

%  posture_joint = joint_location(:,:,1);

    bones_n = size(body_model.bones,1);
    posture_tensor = zeros(bones_n,bones_n,6);
    
    for i = 1: bones_n
        for j = 1: bones_n
            bone1_st = posture_joint(:,body_model.bones(i,1));
            bone1_end = posture_joint(:,body_model.bones(i,2));
            bone2_st = posture_joint(:,body_model.bones(j,1));
            bone2_end = posture_joint(:,body_model.bones(j,2));    
              
            posture_tensor(i,j,:) = get_para_lie_algebra(bone1_st,bone1_end,bone2_st,bone2_end);
            
        end
    end