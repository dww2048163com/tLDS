function distance = generate_action_grass_distance(CU1, CU2, CU3, CU4)

% CU1 = V4_1;
% CU2 = V4_2;
% CU3 = V4_3;
% CU4 = V4_4;

    distance = zeros(size(CU1,3),size(CU1,3));
    
    for i=1:size(CU1,3)       
        i
        for j=1:size(CU1,3)
%             d1 = subspacea(CU1(:,:,i),CU1(:,:,j));            
%             d2 = subspacea(CU2(:,:,i),CU2(:,:,j));         
%             d3 = subspacea(CU3(:,:,i),CU3(:,:,j));
            d4 = subspacea(CU4(:,:,i),CU4(:,:,j));      
            distance(i,j) = norm(d4');
        end
    end
   





end
