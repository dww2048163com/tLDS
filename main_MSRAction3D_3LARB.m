clear;
dataset = 'MSRAction3D';
load([dataset, '/posture_total_label']) ;   
load([dataset, '/action_tensor3_screw']) ;  

rate = zeros(20,5);
 for i=1:20
 J  = [340 5 i];
 O = decomposition_tensors3_with_Kronecker(action_tensors3,J);  

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
 
 action_tensors3_5 = cell(557,1);
for i=1:557
    i
    action_tensor = zeros(361,5,size(action_tensors3{i},3));
    for j=1:size(action_tensors3{i},3)    
        action_tensor(:,:,j) = action_tensors3{i}(:,2:6,j);        
    end
    action_tensors3_5{i} = action_tensor;
end



action_tensors3_114_19 = cell(557,1);
for i=1:557
    i
    action_tensor = zeros(114,19,size(action_tensors4{i},4));
    for j=1:size(action_tensors4{i},4)        
        for s=1:19             
            for t=1:19
                a  = action_tensors4{i}(:,s,:,j);
                b = a(t,:,:);
                b = b(:);
                action_tensor((t-1)*6+1:t*6,s,j) =b;   
            end
        end                
    end
    action_tensors3_114_19{i} = action_tensor;
end



