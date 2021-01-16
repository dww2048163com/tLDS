function [grassSet, grassSet1,grassSet2,grassSet3] = get_subset_info(O,posture_total_label)

 grassSet.X = zeros(size(O{1},1),size(O{1},2),557);
 for i=1:557
    grassSet.X(:,:,i) = O{i};
 end
 
grassSet.y = zeros(1,557);
for i=1:557
    grassSet.y(i) = posture_total_label{i}(1);
end
grassSet.idx = zeros(1,557);
for i=1:280
    grassSet.idx(i) = 1;
end
for i=281:557
    grassSet.idx(i) = 2;
end

subset1 = [2 1; 3 2; 5 3; 6 4; 10 5; 13 6; 18 7; 20 8;];
subset2 = [1 1; 4 2; 7 3; 8 4; 9 5; 11 6; 12 7; 14 8;];
subset3 = [6 1; 14 2; 15 3; 16 4; 17 5; 18 6; 19 7; 20 8;];
subset1_label = [];
subset2_label = [];
subset3_label = [];
subset1_data = [];
subset2_data = [];
subset3_data = [];
for i=1:557
    pos1 = sum(subset1(:,1)==posture_total_label{i}(1));
    pos2 = sum(subset2(:,1)==posture_total_label{i}(1));
    pos3 = sum(subset3(:,1)==posture_total_label{i}(1));
    if pos1==1
        f = find(subset1(:,1)==posture_total_label{i}(1));
        subset1_label =[subset1_label; f];
        subset1_data = [subset1_data O{i}];
    end
    if pos2==1
        f = find(subset2(:,1)==posture_total_label{i}(1));
        subset2_label =[subset2_label; f];
        subset2_data = [subset2_data O{i}];
    end
    if pos3==1
        f = find(subset3(:,1)==posture_total_label{i}(1));
        subset3_label =[subset3_label; f];
        subset3_data = [subset3_data O{i}];
    end
end

subset1_data = reshape(subset1_data,[size(O{1},1),size(O{1},2),size(subset1_data,2)/size(O{1},2)]);
subset2_data = reshape(subset2_data,[size(O{1},1),size(O{1},2),size(subset2_data,2)/size(O{1},2)]);
subset3_data = reshape(subset3_data,[size(O{1},1),size(O{1},2),size(subset3_data,2)/size(O{1},2)]);

grassSet1.X = subset1_data;
grassSet1.y = subset1_label';
grassSet1.idx = zeros(1,size(subset1_label,1));
for i=1:107
    grassSet1.idx(i) = 1;
end
for i=108:size(subset1_label,1)
    grassSet1.idx(i) = 2;
end

grassSet2.X = subset2_data;
grassSet2.y = subset2_label';
grassSet2.idx = zeros(1,size(subset2_label,1));
for i=1:109
    grassSet2.idx(i) = 1;
end
for i=110:size(subset2_label,1)
    grassSet2.idx(i) = 2;
end

grassSet3.X = subset3_data;
grassSet3.y = subset3_label';
grassSet3.idx = zeros(1,size(subset3_label,1));
for i=1:106
    grassSet3.idx(i) = 1;
end
for i=107:size(subset3_label,1)
    grassSet3.idx(i) = 2;
end
