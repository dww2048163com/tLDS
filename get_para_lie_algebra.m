function se_value = get_para_lie_algebra(bone1_st,bone1_end,bone2_st,bone2_end)


        bone1_end = bone1_end - bone1_st;
        bone2_st = bone2_st - bone1_st;
        bone2_end = bone2_end - bone1_st;
        bone1_st = bone1_st - bone1_st;
        
        % Find the rotation matrix that converts bone1_global into x-axis
        R = vrrotvec2mat(vrrotvec(bone1_end, [1, 0, 0]));

        bone1_end = R*bone1_end;
        bone2_st = R*bone2_st;
        bone2_end = R*bone2_end;
        % Find the rotation matrix that converts bone1 into bone2
        % This rotation matrix gives us the rotation between both bones in a
        % coordinate system that is attached to bone 1.
        R = vrrotvec2mat(vrrotvec(bone1_end - bone1_st, bone2_end - bone2_st));
        t = bone2_st - bone1_st;
        se3_points = [R t; [0, 0, 0, 1]];
        se_value = screw_motion_direction_se3(eye(4), se3_points);
       
 
    
