function [U,V,W,A,O,S] = decomposition_tensors4_with_Kronecker1(action_tensors,I,J)

% action_tensors = action_tensors4;

    decomposition_tensors = cell(size(action_tensors,1),1);   
   
    core = cell(size(action_tensors,1),1);
    U = zeros(I(1),J(1),size(action_tensors,1));
    V = zeros(I(2),J(2),size(action_tensors,1));
    W = zeros(I(3),J(3),size(action_tensors,1));
    Q = cell(size(action_tensors,1),1);
    A = cell(size(action_tensors,1),1);  
    O = cell(size(action_tensors,1),1);   
    S = cell(size(action_tensors,1),1);  
        
    for i =1:size(action_tensors,1)  
        i
           
        decomposition_tensors{i} = tucker_als(tensor(action_tensors{i}),[J(1),J(2),J(3),J(4)]);
        core{i} = decomposition_tensors{i}.core;
        U(:,:,i) = decomposition_tensors{i}.U{1};
        V(:,:,i) = decomposition_tensors{i}.U{2};
        W(:,:,i) = decomposition_tensors{i}.U{3};
        Q{i} = decomposition_tensors{i}.U{4};
        % YY = ttm(core{i}, {U(:,:,i),V(:,:,i),W(:,:,i),Q{i}}, [1 2 3 4]);
        % norm(tensor(YY-action_tensors{i}))
        % YY = double(tenmat(YY,4))'; 
        % Y = double(tenmat(action_tensors{i},4))';  
        %  norm(YY-Y,'fro') ;        
        G = double(tenmat(core{i},4));
        %Y = double(tenmat(action_tensors{i},4))';   
        % a = kron(kron(W(:,:,i),V(:,:,i)),U(:,:,i));
        % b = (Q{i}*G)';
        %  norm(Y-a*b,'fro');     
        
        X = (Q{i}*G)';
        t = size(X,2);
        A{i} = X(:,2:t)*pinv(X(:,1:t-1));
        K = kron(kron(W(:,:,i),V(:,:,i)),U(:,:,i));
        B=[];
        for j=1:size(Q{i},2)
            B = [B; K*(A{i}^(j-1))];
        end
        O{i} = B;
        [L,~,~] = svd(O{i},0);
        S{i} = L(:,1:J(4));
    end
