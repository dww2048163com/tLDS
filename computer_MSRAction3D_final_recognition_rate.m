function [CRR,CRR_Sub]= computer_MSRAction3D_final_recognition_rate(action_tensors3,posture_total_label,d)

  
 J  = [18 18 d];
 O = decomposition_tensors3_with_Kronecker(action_tensors3,J);
  

 [grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
 
 

CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
 

