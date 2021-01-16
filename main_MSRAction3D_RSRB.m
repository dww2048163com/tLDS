clear;
dataset = 'MSRAction3D';
load([dataset, '/joint_locations']) ; 
load([dataset, '/posture_total_label']) ;   
load([dataset, '/body_model']) ;   
load([dataset, '/action_tensors3']) ;   

% joint_locations = add_frame_to_action_seq(joint_locations);
% action_tensors1 = generate_action_tensors3(joint_locations1,body_model);
% action_tensors2 = generate_action_tensors3(joint_locations2,body_model);
% action_tensors3 = generate_action_tensors3(joint_locations3,body_model);
% save action_tensors1.mat action_tensors1
% save action_tensors2.mat action_tensors2
% save action_tensors3.mat action_tensors3

joint_locations = add_frame_to_action_seq(joint_locations);
action_tensors3 = generate_action_tensors3(joint_locations,body_model);
 
rate1 = zeros(40,1);   
rate2 = zeros(40,1);     
 for i=13
     i
     [rate1(i),rate2(i)]=computer_MSRAction3D_final_recognition_rate(action_tensors3,posture_total_label,i);
 end
 
 

 I = [19 19];
 J  = [18 18 13];
 O = decomposition_tensors3_with_Kronecker(action_tensors3,J);
 clear action_tensors3

 [grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
 
 clear O;

CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
fprintf('Correct recognition accuracy with a labeled dictionary : %.1f%%.\n',100*CRR_Sub);













