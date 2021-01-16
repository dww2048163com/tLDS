function S = decomposition_tensors4_with_Kronecker(action_tensors,J)

% action_tensors = action_tensors4;

    
    S = cell(size(action_tensors,1),1);  
        
    for i =1:size(action_tensors,1)  
        i
           
        decomposition_tensors = tucker_als(tensor(action_tensors{i}),[J(1),J(2),J(3),J(4)]);
        core = decomposition_tensors.core;
        U = decomposition_tensors.U{1};
        V = decomposition_tensors.U{2};
        W = decomposition_tensors.U{3};
        Q = decomposition_tensors.U{4};
        % YY = ttm(core{i}, {U(:,:,i),V(:,:,i),W(:,:,i),Q{i}}, [1 2 3 4]);
        % norm(tensor(YY-action_tensors{i}))
        % YY = double(tenmat(YY,4))'; 
        % Y = double(tenmat(action_tensors{i},4))';  
        %  norm(YY-Y,'fro') ;        
        G = double(tenmat(core,4));
        %Y = double(tenmat(action_tensors{i},4))';   
        % a = kron(kron(W(:,:,i),V(:,:,i)),U(:,:,i));
        % b = (Q{i}*G)';
        %  norm(Y-a*b,'fro');     
        
        X = (Q*G)';
        t = size(X,2);
        A = X(:,2:t)*pinv(X(:,1:t-1));
        K = kron(kron(W,V),U);
        B=[];
        for j=1:size(Q,2)
            B = [B; K*(A^(j-1))];
        end
        
        [L,~,~] = svd(B,0);
        S{i} = L(:,1:J(4));
    end
