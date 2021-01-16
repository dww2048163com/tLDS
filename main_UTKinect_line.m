clear;
dataset = 'UTKinect';
load([dataset, '/joint_locations']) ; 
load([dataset, '/posture_total_label']) ;   
load([dataset, '/body_model']) ;   

avg=25;
joint_locations = add_frame_to_action_seq(joint_locations,avg);
 

joint_locations_l = cell(199,1);
for i=1:199
    i
    rigid_bodies = zeros(19,9,size(joint_locations{i},3));
    for j=1:size(joint_locations{i},3)
        a = joint_locations{i}(:,:,j);
        for t=1:body_model.n_bones
            rigid_bodies(t,1:3,j) = a(:,body_model.bones(t,1))';
            rigid_bodies(t,4:6,j) = a(:,body_model.bones(t,2))';
            rigid_bodies(t,7:9,j) = a(:,body_model.bones(t,1))'-a(:,body_model.bones(t,2))';            
        end        
    end
    joint_locations_l{i} = rigid_bodies;
end

 rate = zeros(20,11); 
  
 for i=10:20
     i
     rate(i,:) = computer_final_recognition_rate(joint_locations_l,posture_total_label,i);
 end

 
