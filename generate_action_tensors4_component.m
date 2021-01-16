function a = generate_action_tensors4_component(action_tensors4)

    a = cell(6,1);
    c = cell(557,1)
;
    for j=1:6
        for i=1:557    
            b = zeros(19,19,size(action_tensors4{i},4));
            for t=1:size(action_tensors4{i},4)
                b(:,:,t) = double(action_tensors4{i}(:,:,j,t));
            end
            c{i} = b;
        end
        a{j} = c;
    end
end
