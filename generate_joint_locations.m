function joint_locations = generate_joint_locations(dataset)     
        
        load([dataset, '/skeletal_data'])  ;
        load([dataset, '/body_model']) ;             
        
        n_subjects = 10;
        n_actions = 20;
        n_instances = 3;

        n_sequences = length(find(skeletal_data_validity));      
       
        joint_locations = cell(n_sequences, 1);
        action_labels = zeros(n_sequences, 1);
        subject_labels = zeros(n_sequences, 1);
        instance_labels = zeros(n_sequences, 1); 

        count = 1;
        for subject = 1:n_subjects
            for action = 1:n_actions
                for instance = 1:n_instances
                    if (skeletal_data_validity(action, subject, instance))                    

                        joint_locations{count} = skeletal_data{action, subject, instance}.joint_locations;        
                        action_labels(count) = action;       
                        subject_labels(count) = subject;
                        instance_labels(count) = instance;

                        count = count + 1;
                    end
                end
            end
        end
