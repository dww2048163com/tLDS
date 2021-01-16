clear;
dataset = 'MSRAction3D';
load([dataset, '/joint_locations'])  ;
load([dataset, '/posture_total_label']) ;   
load([dataset, '/body_model']) ;  

joint_locations_LRS = cell(557,1);
for i=1:557
    i    
    LRS = zeros(19,19,23,size(joint_locations{i},3));
    for j=1:size(joint_locations{i},3)
        a = joint_locations{i}(:,:,j);
        for s=1:body_model.n_bones
            for t=1:body_model.n_bones
                LRS(s,t,1:3,j) = a(:,body_model.bones(t,1))';
                LRS(s,t,4:6,j) = a(:,body_model.bones(t,2))';
                LRS(s,t,7:9,j) = a(:,body_model.bones(t,1))'-a(:,body_model.bones(t,2))';    
                LRS(s,t,10:12,j) = a(:,body_model.bones(s,1))';
                LRS(s,t,13:15,j) = a(:,body_model.bones(s,2))';
                LRS(s,t,16:18,j) = a(:,body_model.bones(s,1))'-a(:,body_model.bones(s,2))';
                bone1_st = a(:,body_model.bones(t,1));
                bone1_end = a(:,body_model.bones(t,2));
                bone2_st = a(:,body_model.bones(s,1));
                bone2_end = a(:,body_model.bones(s,2));
                v = get_para_lie_algebra(bone1_st,bone1_end,bone2_st,bone2_end);
                LRS(s,t,19:23,j) = v(2:6);
            end
        end        
    end       
    joint_locations_LRS{i} = LRS;
end

inrelative_body_part_pairs=zeros(141,4);
count =1;
for i=1:19
    for j=i+1:19
        inrelative_body_part_pairs(count,1:2) = body_model.bones(i,:);
        inrelative_body_part_pairs(count,3:4) = body_model.bones(j,:);
        count = count +1;
    end
end

joint_locations_LRS3 = cell(557,1);
for i=1:557
    i    
    LRS = zeros(171,18,size(joint_locations{i},3));
    for j=1:size(joint_locations{i},3)
        a = joint_locations{i}(:,:,j);
        for s=1:171 
                LRS(s,1:3,j) = a(:,inrelative_body_part_pairs(s,1))';
                LRS(s,4:6,j) = a(:,inrelative_body_part_pairs(s,2))';
                LRS(s,7:9,j) = a(:,inrelative_body_part_pairs(s,1))'-a(:,inrelative_body_part_pairs(s,2))';    
                LRS(s,10:12,j) = a(:,inrelative_body_part_pairs(s,3))';
                LRS(s,13:15,j) = a(:,inrelative_body_part_pairs(s,4))';
                LRS(s,16:18,j) = a(:,inrelative_body_part_pairs(s,3))'-a(:,inrelative_body_part_pairs(s,4))'; 
%                 bone1_st = a(:,inrelative_body_part_pairs(s,1));
%                 bone1_end = a(:,inrelative_body_part_pairs(s,2));
%                 bone2_st = a(:,inrelative_body_part_pairs(s,3));
%                 bone2_end = a(:,inrelative_body_part_pairs(s,4));
%                 v = get_para_lie_algebra(bone1_st,bone1_end,bone2_st,bone2_end);
%                 LRS(s,1:5,j) = v(2:6);
        end
    end                
    joint_locations_LRS3{i} = LRS;
end



 I = [20 20];
 
 rate = zeros(20,5);
 for i=7:20
 J  = [170 17 i];
 O = decomposition_tensors3_with_Kronecker(joint_locations_LRS3,J);
  
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


