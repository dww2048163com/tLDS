function posture_tensor = generate_posture_tensor3(posture_joint,body_model)

%  posture_joint = joint_location(:,:,1);

    bonesn = size(body_model.bones,1);
    posture_tensor = zeros(bonesn*(bonesn-1),5);
    
    t=1;
    
    for i = 1: bonesn
        for j = 1: bonesn
            if i~=j
               bone1_st = posture_joint(:,body_model.bones(i,1));
               bone1_end = posture_joint(:,body_model.bones(i,2));
               bone2_st = posture_joint(:,body_model.bones(j,1));
               bone2_end = posture_joint(:,body_model.bones(j,2));    
              
               v = get_para_lie_algebra(bone1_st,bone1_end,bone2_st,bone2_end);
               posture_tensor(t,:) = v(2:6);
               t = t+1;
            end
            
        end
    end