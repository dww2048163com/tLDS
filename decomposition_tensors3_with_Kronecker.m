function O = decomposition_tensors3_with_Kronecker(action_tensors,J)

% action_tensors = action_tensors3;
    
    O = cell(size(action_tensors,1),1); 
    
    for i =1:size(action_tensors,1)     
        i
        decomposition_tensors = tucker_als(tensor(action_tensors{i}),[J(1),J(2),J(3)]);
        core = decomposition_tensors.core;
        U = decomposition_tensors.U{1};
        V = decomposition_tensors.U{2};
        W = decomposition_tensors.U{3};
        
        G = double(tenmat(core,3));
        % Y = double(tenmat(action_tensors{i},3))';   
        % norm(Y-kron(V(:,:,i),U(:,:,i))*(W{i}*G)');
        
        X = (W*G)';
        t = size(X,2);
        % e = eigs(X(:,2:t)*pinv(X(:,1:t-1)));
        % norm(e(1))
         
        
        A = X(:,2:t)*pinv(X(:,1:t-1)); 
        B=[];
        for j=1:J(3)
            B = [B; kron(V,U)*(A^(j-1))];
        end        
        [b,~,~] = svd(B,0);
        O{i} = b(:,1:J(3));
    end
