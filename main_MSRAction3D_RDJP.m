clear;
dataset = 'MSRAction3D';
load([dataset, '/action_joint_tensors3']) ; 
load([dataset, '/posture_total_label']) ;   
 I = [20 20];
 J  = [18 18 18];
 O = decomposition_tensors3_with_Kronecker(posture_joint_matrix_tensor,J);

[grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
 
 

CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
 