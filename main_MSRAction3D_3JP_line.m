clear;
dataset = 'MSRAction3D';
load([dataset, '/joint_locations'])  ;
load([dataset, '/posture_total_label']) ;   
load([dataset, '/body_model']) ;  

joint_locations_l = cell(557,1);
for i=1:557
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


 
 
 rate = zeros(20,5);
 for i=1:20
 J  = [18 9 i];
 O = decomposition_tensors3_with_Kronecker(joint_locations_l,J);
  
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
 
 a =zeros(277,2);
 b= zeros(20,20);
 for i=1:277
      b(tst.y(i),y_hat(i)) = b(tst.y(i),y_hat(i)) +1;
       
 end
 c= sum(b,2);
 for i=1:20
     b(i,:) = b(i,:)/c(i);
 end
 
 


