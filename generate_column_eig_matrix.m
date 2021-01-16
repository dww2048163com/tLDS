function [V1,V2,V3,V4] = generate_column_eig_matrix(action_tensor)

% action_tensor = action_tensors{1};
    
     I = size(action_tensor);

     AA1 = double(tenmat(action_tensor,1));
     [U1 S1 V1] = svd(AA1);
     S1 = S1(:,1:I(1));
     V1 = (inv(S1)*inv(U1)*AA1)';
     
     AA2 = double(tenmat(action_tensor,2));
     [U2 S2 V2] = svd(AA2);
     S2 = S1(:,1:I(2));
     V2 = (inv(S2)*inv(U2)*AA2)';
     
     AA3 = double(tenmat(action_tensor,3));
     [U3 S3 V3] = svd(AA3);
     S3 = S3(:,1:I(3));
     V3 = (inv(S3)*inv(U3)*AA3)';
      
     AA4 = double(tenmat(action_tensor,4));
     [U4 S4 V4] = svd(AA4);
     S4 = S4(:,1:I(4));
     V4 = (inv(S4)*inv(U4)*AA4)';

end