clear;
dataset = 'Florence3D';
load([dataset, '/joint_locations']) ; 
load([dataset, '/posture_total_label']) ;   
load([dataset, '/body_model']) ;   

joint_locations = add_frame_to_action_seq(joint_locations);
action_tensors3 = generate_action_tensors3(joint_locations,body_model);


 I = [19 19];
 J  = [18 18 18];
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


