clear;
dataset = 'MSRAction3D';
load([dataset, '/joint_locations'])  ;
load([dataset, '/posture_total_label']) ;   

joint_locations_v = cell(557,1);
for i=1:557
    ma = zeros(60,size(joint_locations{i},3));
    for j=1:size(joint_locations{i},3)
        m = joint_locations{i}(:,:,j);
        m = m(:);
        ma(:,j) = m;
    end
    joint_locations_v{i} = ma;   
end
 
 rate_2JP_SVD = zeros(20,5);
 for i=1:20
   J  = [55 i];
   O = decomposition_tensors2_with_svd(joint_locations_v,J);  
   [grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
   CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
   CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
   CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
   CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
   CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
   rate_2JP_SVD(i,1) = CRR;
   rate_2JP_SVD(i,2) = CRR1;
   rate_2JP_SVD(i,3) = CRR2;
   rate_2JP_SVD(i,4) = CRR3;
   rate_2JP_SVD(i,5) = CRR_Sub;
 end
 
 


