function rate = computer_final_recognition_rate(action_tensors3,posture_total_label,d)

rate = zeros(11,1);

J  = [18 8 d];
 O = decomposition_tensors3_with_Kronecker(action_tensors3,J);
  

 grassSet.X = zeros(size(O{1},1),size(O{1},2),199);
 for i=1:199
    grassSet.X(:,:,i) = O{i};
 end
 grassSet.y = zeros(1,199);
 for i=1:199
    grassSet.y(i) = posture_total_label{i}(1);
 end 
 
CRR = zeros(199,1);
for j=1:199     
    grassSet.idx = zeros(1,199);
    for i=1:199    
     grassSet.idx(i) = 1;
    end 
    grassSet.idx(j) = 2;
    CRR(j) = get_recogniton_rate_dictionary_classificatin(grassSet);
end


CRR_Sub = zeros(10,1);
CRR_Sum = zeros(10,1);
for i=1:10
    for j=1:199
        if posture_total_label{j}(1) == i
            CRR_Sub(i) = CRR_Sub(i)+CRR(j);
            CRR_Sum(i) = CRR_Sum(i)+1;
        end
    end
end

a = CRR_Sub/CRR_Sum;
rate(2:11) = a(1:10,1)';
rate(1) = sum(CRR)/199;
