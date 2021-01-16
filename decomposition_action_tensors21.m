function X = decomposition_action_tensors21(action_tensors, d)

%  action_tensors = action_tensors2;
%  I(1) = 2166;

    X = zeros(19*19*d,d,size(action_tensors,1));
    for i =1:size(action_tensors,1)  
        i
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
        X(:,:,i) = U1;
    end
