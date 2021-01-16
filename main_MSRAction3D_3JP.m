clear;
dataset = 'MSRAction3D';
load([dataset, '/joint_locations'])  ;
load([dataset, '/posture_total_label']) ;   
 I = [20 20];
 
 rate = zeros(20,5);
 for i=1:20
 J  = [3 18 10];
 O = decomposition_tensors3_with_Kronecker(joint_locations,J);
  
[grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
 
CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
CRR_Sub = (CRR1 + CRR2 + CRR3)/3;

rate(i,1) = CRR;
rate(i,2) = CRR1;
rate(i,3) = CRR2;
rate(i,4) = CRR3;
rate(i,5) = CRR_Sub;


 end


