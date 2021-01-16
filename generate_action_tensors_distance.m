function distance = generate_action_tensors_distance(CU1, CU2, CU3, CU4, CU5)

    distance = zeros(size(CU1,3),size(CU1,3));
    
    for i=1:size(CU1,3)
        i
        for j=1:size(CU1,3)
            d1 = subspace(CU1(:,:,i),CU1(:,:,j));            
            d2 = subspace(CU2(:,:,i),CU2(:,:,j));          
            d3 = subspace(CU3(:,:,i),CU3(:,:,j));
%             d4 = subspace(CU4(:,:,i),CU4(:,:,j));          
%             d5 = subspace(CU5(:,:,i),CU5(:,:,j));
            distance(i,j) = norm([d1 d2 d3]);
        end
    end
   





end
