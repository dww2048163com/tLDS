function posture_matrix = generate_posture_joint_matrix(posture)

    % posture = joint_locations{1}(:,:,1)
    
    joints = size(posture,2);
    posture_matrix = zeros(joints);
    
    for i=1:joints
        for j=1:joints
            posture_matrix(i,j) = norm(posture(:,i)-posture(:,j));
        end
    end