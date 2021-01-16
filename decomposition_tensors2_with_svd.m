function O = decomposition_tensors2_with_svd(action_tensors,J)

% action_tensors = joint_locations_l;
    d = J(2);
    O = cell(size(action_tensors,1),1); 
    
    for i =1:size(action_tensors,1) 
        
        [U,S,V] = svd(action_tensors{i},0);
        C = U(:,1:d);   
        S = S(1:d,1:d);
        V = V(:,1:d);
        D1 = zeros(size(V,1)); 
        D2 = zeros(size(V,1));
        D1(2:end,1:end-1) = eye(size(V,1)-1);
        D2(1:end-1,1:end-1) = eye(size(V,1)-1);
        A = (S*V'*D1*V)/(S*V'*D2*V);
        O2 =[];
        for j=1:d
           O1 = (C*A^(j-1))';
           O2 = [O2 O1];
        end
        [U1,~,~] = svd(O2',0);
        O{i} = U1(:,1:d);
    end
        
        
    