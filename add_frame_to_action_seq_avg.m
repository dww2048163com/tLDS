function joint_locations = add_frame_to_action_seq_avg(joint_locations)

t = size(joint_locations,1);
a=0;
for i=1:t
    l = size(joint_locations{i},3);
    a=a+l;
end
avg=floor(a/t);

for i=1:size(joint_locations,1)
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
    if mode ==4
        for j=ceil(diff/4):-1:1
            joint_new_loc = zeros(3,20,size(joint_locations{i},3)+4);
            location_diff = (joint_locations{i}(:,:,j+1) - joint_locations{i}(:,:,j))/5;
            location_new1 = joint_locations{i}(:,:,j) + location_diff;
            location_new2 = joint_locations{i}(:,:,j) + 2*location_diff;
            location_new3 = joint_locations{i}(:,:,j) + 3*location_diff;
            location_new4 = joint_locations{i}(:,:,j) + 4*location_diff;
            joint_new_loc(:,:,1:j) = joint_locations{i}(:,:,1:j); 
            joint_new_loc(:,:,j+1) = location_new1; 
            joint_new_loc(:,:,j+2) = location_new2; 
            joint_new_loc(:,:,j+3) = location_new3; 
            joint_new_loc(:,:,j+4) = location_new4; 
            joint_new_loc(:,:,j+5:end) = joint_locations{i}(:,:,j+1:end);
            joint_locations{i} = joint_new_loc;
        end
    end  
    
     if mode ==5
        for j=ceil(diff/5):-1:1
            joint_new_loc = zeros(3,20,size(joint_locations{i},3)+5);
            location_diff = (joint_locations{i}(:,:,j+1) - joint_locations{i}(:,:,j))/6;
            location_new1 = joint_locations{i}(:,:,j) + location_diff;
            location_new2 = joint_locations{i}(:,:,j) + 2*location_diff;
            location_new3 = joint_locations{i}(:,:,j) + 3*location_diff;
            location_new4 = joint_locations{i}(:,:,j) + 4*location_diff;
            location_new5 = joint_locations{i}(:,:,j) + 5*location_diff;
            joint_new_loc(:,:,1:j) = joint_locations{i}(:,:,1:j); 
            joint_new_loc(:,:,j+1) = location_new1; 
            joint_new_loc(:,:,j+2) = location_new2; 
            joint_new_loc(:,:,j+3) = location_new3; 
            joint_new_loc(:,:,j+4) = location_new4; 
            joint_new_loc(:,:,j+5) = location_new5; 
            joint_new_loc(:,:,j+6:end) = joint_locations{i}(:,:,j+1:end);
            joint_locations{i} = joint_new_loc;
        end
     end  
     if mode ==6
        for j=ceil(diff/6):-1:1
            joint_new_loc = zeros(3,20,size(joint_locations{i},3)+6);
            location_diff = (joint_locations{i}(:,:,j+1) - joint_locations{i}(:,:,j))/7;
            location_new1 = joint_locations{i}(:,:,j) + location_diff;
            location_new2 = joint_locations{i}(:,:,j) + 2*location_diff;
            location_new3 = joint_locations{i}(:,:,j) + 3*location_diff;
            location_new4 = joint_locations{i}(:,:,j) + 4*location_diff;
            location_new5 = joint_locations{i}(:,:,j) + 5*location_diff;
            location_new6 = joint_locations{i}(:,:,j) + 6*location_diff;
            joint_new_loc(:,:,1:j) = joint_locations{i}(:,:,1:j); 
            joint_new_loc(:,:,j+1) = location_new1; 
            joint_new_loc(:,:,j+2) = location_new2; 
            joint_new_loc(:,:,j+3) = location_new3; 
            joint_new_loc(:,:,j+4) = location_new4; 
            joint_new_loc(:,:,j+5) = location_new5; 
            joint_new_loc(:,:,j+6) = location_new6; 
            joint_new_loc(:,:,j+7:end) = joint_locations{i}(:,:,j+1:end);
            joint_locations{i} = joint_new_loc;
        end
    end  
        
end
