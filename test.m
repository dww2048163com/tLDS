clear

action_tensors2 = cell(557,1);
for i=1:557
    a = zeros(2166,size(action_tensors4{i},4));
    for j=1:size(action_tensors4{i},4)
        a(:,j) = reshape(action_tensors4{i}(:,:,:,j),[2166,1]);
    end
    action_tensors2{i} = a;
end
save action_tensors2.mat action_tensors2

ddd = zeros(20,54);
for i=1:20
    for j=1:54
        ddd(i,j) = norm(C{1}(:,i)-action_tensors2{1}(:,j));
    end
end


clc
ddd = zeros(557,1);
for i = 1:557
    i
         
        ddd(i) = norm(tensor(core{i}-core1{i}));
   
end

M = randn(14,13,12,40); %<-- A 4 x 3 x 2 array.
X = tensor(M);
T = tucker_als(X,[10,10,10,30]);
Y = ttm(T.core, {T.U{1},T.U{2},T.U{3},T.U{4}}, [1 2 3 4]) ;
norm(Y-X);
norm(X)
norm(Y)

M = randn(30,20); %<-- A 4 x 3 x 2 array.
X = tensor(M);
T = tucker_als(X,[20,19]);
Y = ttm(T.core, {T.U{1},T.U{2}}, [1 2]) ;
U = T.U{1};
V = T.U{2};
C = T.core;
G = double(tenmat(C,2));
XX = U*(V*G)';
[U1,S1,V1] = svd(M,0);
norm(U1-U);
norm(U)
a=(V*G)';
A = a(:,2:20)/a(:,1:19);


M1 = randn(22,22,12); %<-- A 4 x 3 x 2 array.
X1 = tensor(M1);
T1 = tucker_als(X1,[21,21,11]);
Y1 = ttm(T1.core, {T1.U{1},T1.U{2},T1.U{3}}, [1 2 3]) ;
norm(Y1-X1); 
norm(X1);
norm(Y1);

subspacea(T1.U{1},T.U{1})
subspacea(T1.U{2},T.U{2})
subspacea(T1.U{3},T.U{3})

Z = double(X);
double(Y)

core = tensor(rand(3,2,1),[3 2 1]); %<-- The core tensor.
U = {rand(5,3), rand(4,2), rand(3,1)}; %<-- The matrices.
X = ttensor(core,U) %

T = tucker_als(X,[3 2 1]);

M = randn(4,3,2); %<-- A 4 x 3 x 2 array.
X = tensor(M)
U1 = nvecs(X,1,4); %<-- Mode 1
U2 = nvecs(X,2,3); %<-- Mode 2
U3 = nvecs(X,3,2); %<-- Mode 3
S = ttm(X,{pinv(U1),pinv(U2),pinv(U3)}); %<-- Core
R = ttensor(S,{U1,U2,U3}) %<-- HOSVD of X

norm(X)
norm(R)
norm(X-double(R))

i=1;
X1 = action_tensors4{i};
j=2;
X2 = tensor(action_tensors4{j});
X1 = tensor(X1);
S1 = ttm(X1,{pinv(CU1(:,:,i)),pinv(CU2(:,:,i)),pinv(CU3(:,:,i)),pinv(CU4{i})}); %<-- Core
R1 = ttensor(S1,{CU1(:,:,i),CU2(:,:,i),CU3(:,:,i),CU4{i}}); %<-- HOSVD of X
S1 = ttm(core{i},{CU1(:,:,i),CU2(:,:,i),CU3(:,:,i),CU4{i}}); %<-- Core

R1 = tensor(R1);
norm(X1)
norm(R1)

norm(X1-R1)
norm(X1-S1)


C = tensor(action_tensors_warping{2}(:,:,:,:,1));
X0 = rand(1,18);
Y = ttm(C,X0,4);
Y(:,:,:,1) = tensor(action_tensors4{2}(:,:,:,1));
CM = tenmat(C,4);
YM = tenmat(Y,4);
X0 = double(YM)*pinv(double(CM));
Y1 = ttm(C,X0,4);
norm(Y-Y1)

clc;
Y = tensor(action_tensors4{2}(:,:,:,1));
for i=0:200
    i
CA = ttm(C,A(:,:,2)^i,4);
Y2 = ttm(CA,X0,4);
norm(tensor(double(Y2)-double(Y)))
end

clc
ddd = zeros(54,400);
for i = 1:400
    for j=1:54
        t1 = action_tensors_warping{1}(:,:,:,i);
        a1 = action_tensors4{1}(:,:,:,j);
        ddd(i,j) = norm(tensor(t1-a1));
    end
end

clc
ddd = zeros(400,400);
for i = 1:400
    for j=1:400
        t1 = action_tensors_warping{1}(:,:,:,i);
        a1 = action_tensors_warping{1}(:,:,:,j);
        ddd(i,j) = norm(tensor(t1-a1));
    end
end

clc
ddd = zeros(20,20);
for i = 1:20
    for j = 1:20
        t1 = action_tensors_warping{1}(:,:,:,(i-1)*20+1:i*20);
        a1 = action_tensors_warping{7}(:,:,:,(j-1)*20+1:j*20);
        ddd(i,j) = norm(tensor(t1-a1));
    end
end


clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = norm(tensor(action_tensors_warping{i}-action_tensors_warping{j}));
    end
end


clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = norm(tensor(core{i}-core{j}));
    end
end

clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = norm(CU1(:,:,i)-CU1(:,:,j),'fro');
    end
end

clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = subspace(CU2(:,:,i),CU2(:,:,j));
    end
end

clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = subspace(A(:,:,i),A(:,:,j));
    end
end

clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = norm(V4_1(:,:,i)-V4_1(:,:,j),'fro');
    end
end

clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        a = subspacea(V4_4(:,:,i),V4_4(:,:,j));
        b = cumprod(1./cos(a));
        ddd(i,j) = log(b(end));
    end
end

clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = subspace(V4_1(:,:,i),V4_1(:,:,j));
    end
end


clc

ddd1 = zeros(54,20);
for i = 1:54
    i
    for j=1:20        
        a = action_tensors4{1}(:,:,:,i);
        b = action_tensors{1}(:,:,:,j);
        ddd1(i,j) = norm(tensor(a-b));
    end
end
[ss,sss] = min(ddd1,[],2)

clc

ddd = zeros(20,20);
for i = 1:20
    i
    for j=1:20        
        a = action_tensors{7}(:,:,:,i);
        b = action_tensors{7}(:,:,:,j);
        ddd(i,j) = norm(tensor(a-b));
    end
end

clc

ddd = zeros(54,54);
for i = 1:54
    i
    for j=1:54        
        a = action_tensors4{1}(:,:,:,i);
        b = action_tensors4{1}(:,:,:,j);
        ddd(i,j) = norm(tensor(a-b));
    end
end

n=60;
m = 10;
action_warp = cell(n*m,1);
for i =1:n
    i
    for j=1:m
        action_warp{(i-1)*m+j} = action_tensors_warping{i}(:,:,:,:,j);
    end
end

ddd = zeros(n*m,n*m);
for i = 1:n*m
    i
    for j=1:n*m
        ddd(i,j) = norm(tensor(action_warp{i}-action_warp{j}));
    end
end

n = 100;
AA = A(:,:,1);
D = cell(n,1);
for i=1:n
    D{i} = AA^i;
end
ddd = zeros(n,n);
for i=1:n
    for j=1:n 
        ddd(i,j) = norm(D{i}-D{j});
    end
end
[a,b,c] = svd(AA);

c1 = cell(557,1);
c2 = cell(557,1);
for i=1:557
    c1{i} = CU1(:,:,i)*CU1(:,:,i)'; 
    c2{i} = CU2(:,:,i)*CU2(:,:,i)'; 
end
clc
ddd = zeros(557,557);
for i = 1:557
    i
    for j=1:557        
        ddd(i,j) = norm(c1{i}-c1{j},'fro')+ norm(c2{i}-c2{j},'fro');
    end
end







