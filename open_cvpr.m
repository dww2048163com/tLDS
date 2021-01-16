clear;
dataset = 'MSRAction3D';
load([dataset, '/joint_locations']) ; 
load([dataset, '/posture_total_label']) ;   
load([dataset, '/body_model']) ;   

joint_locations = add_frame_to_action_seq(joint_locations,25);
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
 rate_2JP_SVD1 = sum(rate_2JP_SVD(6:20,:))/15;
 
 rate_2JP = zeros(20,5);
 for i=1:20
    J  = [55 i];
    O = decomposition_tensors2_with_Kronecker(joint_locations_v,J);
    [grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
    CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
    CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
    CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
    CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
    CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
    rate_2JP(i,1) = CRR;
    rate_2JP(i,2) = CRR1;
    rate_2JP(i,3) = CRR2;
    rate_2JP(i,4) = CRR3;
    rate_2JP(i,5) = CRR_Sub;
 end
 rate_2JP1 = sum(rate_2JP(6:20,:))/15;
 
 rate_3JP = zeros(20,5);
 for i=1:20
     J  = [3 18 i];
     O = decomposition_tensors3_with_Kronecker(joint_locations,J);
     [grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
     CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
     CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
     CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
     CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
     CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
     rate_3JP(i,1) = CRR;
     rate_3JP(i,2) = CRR1;
     rate_3JP(i,3) = CRR2;
     rate_3JP(i,4) = CRR3;
     rate_3JP(i,5) = CRR_Sub;
 end
 rate_3JP1 = sum(rate_3JP(6:20,:))/15;
 
 joint_locations_l = cell(557,1);
for i=1:557
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
 rate_3Line = zeros(20,5);
 for i=1:20
    J  = [18 8 i];
    O = decomposition_tensors3_with_Kronecker(joint_locations_l,J);
    [grassSet,grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label);
    CRR = get_recogniton_rate_dictionary_classificatin(grassSet);
    CRR1 = get_recogniton_rate_dictionary_classificatin(grassSet1);
    CRR2 = get_recogniton_rate_dictionary_classificatin(grassSet2);
    CRR3 = get_recogniton_rate_dictionary_classificatin(grassSet3);
    CRR_Sub = (CRR1 + CRR2 + CRR3)/3;
    rate_3Line(i,1) = CRR;
    rate_3Line(i,2) = CRR1;
    rate_3Line(i,3) = CRR2;
    rate_3Line(i,4) = CRR3;
    rate_3Line(i,5) = CRR_Sub;
 end
  rate_3Line1 = sum(rate_3Line(6:20,:))/15;
 

