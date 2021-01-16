dataset = 'MSRAction3D';
load([dataset, '/joint_locations'])  ;
load([dataset, '/body_model']) ;   
action_tensors3 = generate_action_tensors3(joint_locations,body_model);
action_tensors4 = generate_action_tensors4(joint_locations,body_model);

save action_tensors4.mat action_tensors4
save action_tensors3.mat action_tensors3

load([dataset, '/joint_locations'])  ;
load([dataset, '/body_model']) ;   
load([dataset, '/action_tensors3'])  ;
action_tensor_component = generate_action_tensors4_component(action_tensors4);




 I = [19 19 6];
 J  = [10 10 5 10];
%[core1,CU11,CU21,CU31,CU41,A1] = decomposition_action_tensors4(action_tensors4,I,J);
[core,CU1,CU2,CU3,CU4,A] = decomposition_action_tensors3(action_tensors4,I,J);

action_tensors_warping = generate_action_tensors4_warping(core, CU1, CU2, CU3, A, I);

action_tensors_observ = cell(557,1);
for i=1:557
    action_tensor_observ = zeros(size(action_tensors_warping{1},1),size(action_tensors_warping{1},2),size(action_tensors_warping{1},3),size(action_tensors_warping{1},4)*size(action_tensors_warping{1},5));
    for j=1:size(action_tensors_warping{1},5)
        action_tensor_observ(:,:,:,(j-1)*size(action_tensors_warping{1},5)+1:j*size(action_tensors_warping{1},5)) = action_tensors_warping{i}(:,:,:,:,j);
    end
    action_tensors_observ{i} = action_tensor_observ;
end

X = genrate_hidden_state_vector(action_tensors4,action_tensors_warping,A,J);

d=25;
action_tensors = genrate_observability_tensor(action_tensors_warping,A,X,I,d);

save action_tensors50.mat action_tensors

 I = size(action_tensors{1});
[V4_1,V4_2,V4_3,V4_4] = decomposition_action_tensors4_warping(action_tensors,I);

save V4_1.mat V4_1
save V4_2.mat V4_2
save V4_3.mat V4_3
save V4_4.mat V4_4

distance = generate_action_grass_distance(V4_1, V4_2, V4_3, V4_4);




 I = [19 19 6 20 10];
 J  = [16 16 5 15 8];
[ CU1, CU2, CU3, CU4, CU5] = decomposition_action_tensors_warping(action_tensors_warping,I,J);
distance = generate_action_tensors_distance(CU1, CU2, CU3, CU4, CU5);










 I = [19 19];
 J  = [16 16 18];
[core, CU1, CU2, A] = decomposition_action_tensors3(action_tensors3,I,J);

dim = 1;
action_tensors_warping = generate_action_tensors_warping(core, CU1, CU2, A,dim);

 I = [19 19 18];
 J  = [16 16 16];
[core, CU1, CU2, CU3] = decomposition_action_tensors_warping(action_tensors_warping,I,J);

distance = generate_action_tensors_distance(CU1, CU2, CU3);

sum =0;
max =0;
min =100;
for i=1:557
    sum = sum + size(joint_locations{i},3);
    if size(joint_locations{i},3)>max
        max = size(joint_locations{i},3);
    end
    if size(joint_locations{i},3)<min
        min = size(joint_locations{i},3);
    end
end
avg=ceil(sum/557);
 
for i=1:557
    diff=0;
    if size(joint_locations{i},3)<avg
        diff = avg - size(joint_locations{i},3);
    end
    mode = ceil(diff/(size(joint_locations{i},3)-1));
    if mode==1
        for j=diff:-1:1
            joint_new_loc = zeros(3,20,size(joint_locations{i},3)+1);
            location_new = (joint_locations{i}(:,:,j+1) + joint_locations{i}(:,:,j))/2;
            joint_new_loc(:,:,1:j) = joint_locations{i}(:,:,1:j); 
            joint_new_loc(:,:,j+1) = location_new; 
            joint_new_loc(:,:,j+2:end) = joint_locations{i}(:,:,j+1:end);
            joint_locations{i} = joint_new_loc;
        end
    end
    if mode==2
        for j=ceil(diff/2):-1:1
            joint_new_loc = zeros(3,20,size(joint_locations{i},3)+2);
            location_diff = (joint_locations{i}(:,:,j+1) - joint_locations{i}(:,:,j))/3;
            location_new1 = joint_locations{i}(:,:,j) + location_diff;
            location_new2 = joint_locations{i}(:,:,j) + location_diff + location_diff;
            joint_new_loc(:,:,1:j) = joint_locations{i}(:,:,1:j); 
            joint_new_loc(:,:,j+1) = location_new1; 
            joint_new_loc(:,:,j+2) = location_new2; 
            joint_new_loc(:,:,j+3:end) = joint_locations{i}(:,:,j+1:end);
            joint_locations{i} = joint_new_loc;
        end
    end
    if mode ==3
        for j=ceil(diff/3):-1:1
            joint_new_loc = zeros(3,20,size(joint_locations{i},3)+3);
            location_diff = (joint_locations{i}(:,:,j+1) - joint_locations{i}(:,:,j))/4;
            location_new1 = joint_locations{i}(:,:,j) + location_diff;
            location_new2 = joint_locations{i}(:,:,j) + 2*location_diff;
            location_new3 = joint_locations{i}(:,:,j) + 3*location_diff;
            joint_new_loc(:,:,1:j) = joint_locations{i}(:,:,1:j); 
            joint_new_loc(:,:,j+1) = location_new1; 
            joint_new_loc(:,:,j+2) = location_new2; 
            joint_new_loc(:,:,j+3) = location_new3; 
            joint_new_loc(:,:,j+4:end) = joint_locations{i}(:,:,j+1:end);
            joint_locations{i} = joint_new_loc;
        end
    end  
        
end

save joint_locations_new.mat joint_locations

posture_joint_matrix_tensor = cell(557,1);
for i =1:557
    i
    posture_joint_matrix = zeros(20,20,size(joint_locations{i},3));
    for j=1:size(joint_locations{i},3)
         posture_joint_matrix(:,:,j)= generate_posture_joint_matrix(joint_locations{i}(:,:,j));
    end
    posture_joint_matrix_tensor{i} = posture_joint_matrix;
end

save action_joint_tensors3.mat posture_joint_matrix_tensor

action_tensors2 = cell(557,1);
for i=1:557
    action_tensors2{i} = reshape(action_tensors3{i},[361,size(action_tensors3{i},3)]);
end
save action_joint_tensors2.mat action_tensors2

u_action = cell(557,1);
v_action = cell(557,1);
for i=1:557
    u_a = zeros(114,19,size(action_tensors3_114_19{i},3));
    v_a = zeros(19,19,size(action_tensors3_114_19{i},3));
    for j =1:size(action_tensors3_114_19{i},3)
        [u,s,v] = svd(action_tensors3_114_19{i}(:,:,j),0);
        u_a(:,:,j) = u;
        v_a(:,:,j) = v;
    end    
    u_action{i} = u_a;
    v_action{i} = v_a;
end

for i=1:54
    value = zeros(54,54);
    for j=1:54
        for t=1:54
            s = subspacea(u_action{i}(:,:,j),u_action{i}(:,:,t));
           
            value(j,t) = norm(s);
        end
    end
end

for i=1:54
    value = zeros(54,54);
    for j=1:54
        for t=1:54
            s = subspacea(u_action{i}(:,:,j),u_action{i}(:,:,t));
            value(j,t) = 2*norm(sin(s./2))
            %s = s.^20;
            %value(j,t) = norm(s(1:17));
        end
    end
end


    value = zeros(54,54);    
     for j=1:54
        for t=1:54
           value(j,t) = grassmann_proj( u_action{1}(:,:,j), u_action{1}(:,:,t))  ;     
        end
     end
    
     value = zeros(54,54);    
     for j=1:54
        for t=1:54
            x = u_action{1}(:,:,j)'*u_action{1}(:,:,j);
           value(j,t) = grassmann_proj( u_action{1}(:,:,j), u_action{1}(:,:,t))  ;     
        end
    end
value = 19-value;

value = grassmann_proj( u_action{1} )  ;     
 

u_action = cell(557,1);
v_action = cell(557,1);
for i=1:557
    u_a = zeros(19,19,size(action_tensors3{i},3));
    v_a = zeros(19,19,size(action_tensors3{i},3));
    for j =1:size(action_tensors3{i},3)
        [u,s,v] = svd(action_tensors3{i}(:,:,j),0);
        u_a(:,:,j) = u;
        v_a(:,:,j) = v;
    end    
    u_action{i} = u_a;
    v_action{i} = v_a;
end

