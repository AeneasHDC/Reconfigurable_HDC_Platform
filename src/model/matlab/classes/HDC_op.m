%%
 % @file HDC_class.py
 % @brief Matlab class for instantiating and handling classification problems
 %        in the Hyperdimensional Computing (HDC) framework.
 %        This class instantiates the HDC model according to the configuration
 %        parameters specified in the config_py.py file and provides all the necessary
 %        methods to train and test the model.
 %        The class is highly customizable, allowing the user to verify the
 %        performance of the HDC model with different configurations in terms of:
 %        - HV dimensionality
 %        - HV data type (binary or bipolar)
 %        - HV mode (dense or sparse)
 %        - HV level type (linear, approximately linear, thermometer)
 %        - HV similarity method (Hamming, DotProduct, Cosine)
 %        - HV Encoding techniques:
 %             - BaseHV+LevelHV, denoted as record-based.          
 %             - LevelHV+Permutation, denoted as N-gram based      
 %        - Encoding of temporal sequences (N-gram encoding) 
 %        - HV clipping techniques(both for encoding and classification):
 %             - Binary clipping
 %             - Bipolar clipping
 %             - Quantized clipping
 %             - No clipping
 %        - Retraining                                             
 %        - Learning rate                                          
 %        - Learning Rate decay:
 %             - data-dependent decay (different learning rate as a function of similarity)                     
 %             - iteration-dependent decay (different learning rate as a function of the number of iterations)  
 %        - Sparse HVS with Context-dependent Thinning (CDT)       # NEW
 %        - etc.
 %        More information about the HDC model can be found in the following
 %        accompanying research paper: paper_citation

 % @author Marco Angioli and Saeid Jamili
 % @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
 % @date Created on: 12th August 2023
 % @date Last updated on: 17th August 2023
 % @institution Sapienza University of Rome
 % @version 1.0.2
 % @ref :
 % https://doi.org/10.xxxx/yyyyy
 %

classdef HDC_op
    
    properties
        D
        HV_type
        num_levels
        num_features
        lv_technique
        density
        HV_similarity
        baseValue
        sparsity_factor
    end
    
    methods
        function obj = HDC_op(Dimensionality, HV_type, density, sparsity_factor, Number_of_features, Number_of_levels, LevelTechnique, similarity, encoding_technique)
            obj.D = Dimensionality;
            obj.HV_type = HV_type;
            obj.num_levels = Number_of_levels;
            obj.num_features = Number_of_features;
            obj.lv_technique = LevelTechnique;
            obj.density = density;
            obj.HV_similarity = similarity;

            if strcmp(HV_type, 'BIPOLAR')
                obj.baseValue = -1;
            elseif strcmp(HV_type, 'BINARY')
                obj.baseValue = 0;
            else
                error('Error: Not supported data type. You can only choose between BINARY and bipolar.');
            end
            obj.sparsity_factor = sparsity_factor;
        end
        
        function baseHVs = generate_BaseHVs(obj)
            baseHVs = zeros(obj.num_features, obj.D);
            indexVector = 1:obj.D;
            
            if strcmp(obj.density, 'DENSE')
                change = floor(obj.D / 2);
            else
                change = floor(obj.D * obj.sparsity_factor);
            end
            
            for i = 1:obj.num_features
                baseVector = obj.baseValue * ones(1, obj.D);
                toOne = randperm(obj.D, change);
                baseVector(toOne) = 1;
                baseHVs(i, :) = baseVector;
            end
        end
        
        function levelHVs = generate_LevelVector(obj)
            if strcmp(obj.lv_technique, 'LINEAR')
                levelHVs = zeros(obj.num_levels, obj.D);
                indexVector = 1:obj.D;
                nextLevel = floor(obj.D / (2 * obj.num_levels));
                
                if strcmp(obj.density, 'DENSE')
                    change = floor(obj.D / 2);
                else
                    change = floor(obj.D * obj.sparsity_factor);
                end

                for level = 1:obj.num_levels
                    if level == 1
                        baseVector = obj.baseValue * ones(1, obj.D);
                        toOne = randperm(obj.D, change);
                    else
                        if strcmp(obj.density, 'DENSE')
                            toOne = randperm(obj.D, nextLevel);
                        else
                            zero_indeces = (baseVector == 0);
                            one_indeces = (baseVector ~= 0);
                            toZero = zero_indeces(randperm(length(zero_indeces), nextLevel / 2));
                            indexVector = setdiff(indexVector, toZero);

                            toOne = one_indeces(randperm(length(one_indeces), nextLevel / 2));
                        end
                    end

                    indexVector = setdiff(indexVector, toOne);

                    if strcmp(obj.HV_type, 'BIPOLAR')
                        baseVector(toOne) = baseVector(toOne) * -1;
                        if strcmp(obj.density, 'SPARSE') && level ~= 1
                            baseVector(toZero) = 0;
                        end
                    else
                        baseVector(toOne) = 1 - baseVector(toOne);
                        if strcmp(obj.density, 'SPARSE') && level ~= 1
                            baseVector(toZero) = 0;
                        end
                    end

                    levelHVs(level, :) = baseVector;
                end
                elseif strcmp(obj.lv_technique, 'THERMOMETER')
                levelHVs = zeros(obj.num_levels, obj.D);
                
                for level = 1:obj.num_levels
                    num_ones = ceil((level + 1) * obj.D / (2 * obj.num_levels));
                    levelHVs(level, 1:num_ones) = 1;
                end
                
            elseif strcmp(obj.lv_technique, 'APPROX')
                levelHVs = zeros(obj.num_levels, obj.D);
                indexVector = 1:obj.D;
                
                if strcmp(obj.density, 'DENSE')
                    change = floor(obj.D / 2);
                else
                    change = floor(obj.D * obj.sparsity_factor);
                end
                
                % First random HV
                toOne = randperm(length(indexVector), change);
                levelHVs(1, :) = ones(1, obj.D) * obj.baseValue;
                levelHVs(1, toOne) = 1;
                
                % Last Random HV
                toOne = randperm(length(indexVector), change);
                levelHVs(obj.num_levels, :) = ones(1, obj.D) * obj.baseValue;
                levelHVs(obj.num_levels, toOne) = 1;
                
                for level = 2:obj.num_levels-1
                    num_elements_from_first = ceil(obj.D * (1 - level / obj.num_levels));
                    num_elements_from_last = obj.D - num_elements_from_first;
                    
                    first_part = levelHVs(1, 1:num_elements_from_first);
                    second_part = levelHVs(obj.num_levels, obj.D - num_elements_from_last + 1:end);
                    
                    levelHVs(level, :) = [first_part, second_part];
                end
            end
        end

        
        function similarity = similarity(obj, HV1, HV2)
            if strcmp(obj.density, 'SPARSE')
                and_vector = HV1 & HV2;
                similarity = sum(and_vector) / sum(HV1);
            else
                if strcmp(obj.HV_similarity, 'SIMI_HAM')
                    % HAMMING DISTANCE
                    hamming_distance = sum(HV1 ~= HV2);
                    similarity = hamming_distance / length(HV1);
                else
                    dotp = dot(HV1, HV2);
                    if strcmp(obj.HV_similarity, 'SIMI_DPROD')
                        % DOT PRODUCT
                        similarity = dotp;
                    elseif strcmp(obj.HV_similarity, 'SIMIL_COS')
                        % COSINE SIMILARITY
                        similarity = dotp / (norm(HV1) * norm(HV2));
                    end
                end
            end
        end
        
        function bound_HV = bind(obj, HV1, HV2)
            if strcmp(obj.HV_type, 'BINARY')
                bound_HV = bitxor(HV1, HV2);
            else
                bound_HV = HV1 .* HV2;
            end
        end
        
        function permuted_HV = permutation(obj, HV, positions)
            permuted_HV = circshift(HV, positions);
        end
        
        function bundled_HV = bundle(obj, HV1, HV2)
            bundled_HV = HV1 + HV2;
        end
        
        function clipped_HV = clip(obj, HV, min_value, max_value, clipping_type, bundled_HVs)
            clipped_HV = zeros(1, obj.D);
            if clipping_type == 0
                clipped_HV = HV;
            elseif clipping_type == 1
                if strcmp(obj.HV_type, 'BINARY')
                    random_array = randi([0, 1], 1, obj.D);
                    clipped_HV(HV > bundled_HVs / 2) = 1;
                    clipped_HV(HV == bundled_HVs / 2) = random_array(HV == bundled_HVs / 2);
                    clipped_HV(HV < bundled_HVs / 2) = 0;
                else
                    clipped_HV = sign(HV);
                    random_array = 2 * randi([0, 1], 1, obj.D) - 1;
                    clipped_HV(clipped_HV == 0) = random_array(clipped_HV == 0);
                end
            elseif clipping_type == 2
                clipped_HV = sign(HV);
            elseif clipping_type == 3
                clipped_HV(HV < min_val) = min_val;
                clipped_HV(HV > max_val) = max_val;
            else
                error('ERROR: Invalid clipping mode!');
            end
        end
        
        function result = context_dependent_thinning(obj, Z, bundled_HVs, thinning_steps)
            thinned_HV = zeros(1, obj.D);
            permuted_HV = zeros(1, obj.D);

            for i = 1:thinning_steps
                permuted_HV = obj.permutation(Z, i);
                thinned_HV = thinned_HV | permuted_HV;
            end

            result = Z & thinned_HV;
        end

        function encoded_t = encoding(obj, feature_vector, BaseHVs, LevelHVs, levels, clipping_type, quant_min, quant_max, encoding_technique)
            out_HVs = zeros(1, obj.D);
            quantized_levels = zeros(1, obj.num_features);
            encoded_t = zeros(1, obj.D);
            
            if strcmp(obj.density, 'SPARSE')
                for i = 1:obj.num_features
                    quantized_levels(i) = get_quantized_level(feature_vector(i), levels);
                    index = floor(quantized_levels(i)) + 1;
                    encoded_t = encoded_t | LevelHVs(index, :);
                end
                encoded_t = obj.context_dependent_thinning(encoded_t, obj.num_features, obj.num_features * 5);
            else
                if strcmp(encoding_technique, 'ENCODING_RECORD')
                    for i = 1:obj.num_features
                        quantized_levels(i) = get_quantized_level(feature_vector(i), levels);
                        index = floor(quantized_levels(i)) + 1;
                        out_HVs = obj.bind(BaseHVs(i, :), LevelHVs(index, :));
                        encoded_t = obj.bundle(out_HVs, encoded_t);
                    end
                else
                    for i = 1:obj.num_features
                        quantized_levels(i) = get_quantized_level(feature_vector(i), levels);
                        index = floor(quantized_levels(i)) + 1;
                        out_HVs = obj.permutation(LevelHVs(index, :), i - 1);
                        encoded_t = obj.bundle(out_HVs, encoded_t);
                    end
                end
                encoded_t = obj.clip(encoded_t, quant_min, quant_max, clipping_type, obj.num_features);
            end
        end
        
        function [quantized_levels, BaseHVs, LevelHVs, ClassHVs] = train(obj, train_data, train_labels, num_classes, quant_levels, DS_DATA_RANGE_MIN,DS_DATA_RANGE_MAX, clipping_encoding,  quant_min, quant_max, clipping_class, verbose, n_gram, n_gram_size, encoding_technique)
            num_train_samples = size(train_data, 1);
            
            encoded_HVs = zeros(1, obj.D);
            ClassHVs = zeros(num_classes, obj.D);
            bundled_labels = zeros(1, num_classes);
            n_gram_HV = zeros(1, obj.D);
            temporal_HV = zeros(n_gram_size, obj.D);

            BaseHVs = obj.generate_BaseHVs();
            LevelHVs = obj.generate_LevelVector();
            quantized_levels = quantization_levels(DS_DATA_RANGE_MIN, DS_DATA_RANGE_MAX, quant_levels);

            for i = 1:num_train_samples
                if mod(i, floor(num_train_samples / 10)) == 0 && verbose == 1
                    percentage = (i / num_train_samples) * 100;
                    fprintf('Iteration: %d Progress: %.0f%%\n', i, ceil(percentage));
                end

                if n_gram == 0
                    encoded_HVs = obj.encoding(train_data(i, :), BaseHVs, LevelHVs, quantized_levels, clipping_encoding, quant_min, quant_max, encoding_technique);
                    label = train_labels(i) + 1;
                    ClassHVs(label, :) = obj.bundle(ClassHVs(label, :), encoded_HVs);
                    bundled_labels(label) = bundled_labels(label) + 1;
                else
                    if train_labels(i) == train_labels(i + n_gram_size - 1)
                        label = train_labels(i + n_gram_size - 1) + 1;
                        for j = 1:n_gram_size
                            encoded_HVs = obj.encoding(train_data(i + j - 1, :), BaseHVs, LevelHVs, quantized_levels, clipping_encoding, encoding_technique);
                            temporal_HV(j, :) = obj.permutation(encoded_HVs, j - 1);
                            n_gram_HV = obj.bundle(temporal_HV(j, :), n_gram_HV);
                            n_gram_HV = obj.clip(n_gram_HV, quant_min, quant_max, clipping_encoding, n_gram_size);
                        end
                        ClassHVs(label, :) = obj.bundle(ClassHVs(label, :), n_gram_HV);
                        bundled_labels(label) = bundled_labels(label) + 1;
                    end
                end
            end

            fprintf('ClassHVs before clipping: %s\n', mat2str(ClassHVs));
            
            for i = 1:num_classes
                ClassHVs(i, :) = obj.clip(ClassHVs(i, :), quant_min, quant_max, clipping_class, bundled_labels(i));
            end
            
            fprintf('ClassHVs after clipping: %s\n', mat2str(ClassHVs));
        end


        function [accuracy, estimated_class] = predict(obj, test_data, test_labels, num_classes, quantized_levels, BaseHVs, LevelHVs, ClassHVs, clipping_encoding,  quant_min, quant_max, verbose, n_gram, n_gram_size, encoding_technique)
            num_test_samples = size(test_data, 1);

            estimated_class = zeros(1, num_test_samples);
            actual_class = zeros(1, num_test_samples);
            n_gram_HV = zeros(1, obj.D);
            testedHV = zeros(1, obj.D);

            if strcmp(obj.HV_type, 'BIPOLAR') || strcmp(obj.density, 'SPARSE')
                similarities = zeros(1, num_classes);
            else
                similarities = ones(1, num_classes);
            end

            correct = 0;
            for i = 1:num_test_samples
                if n_gram == 0
                    testedHV = obj.encoding(test_data(i, :), BaseHVs, LevelHVs, quantized_levels, clipping_encoding,quant_min, quant_max,  encoding_technique);
                    actual_class(i) = test_labels(i) + 1;
                else
                    if test_labels(i) == test_labels(i + n_gram_size)
                        actual_class(i) = test_labels(i + n_gram_size) + 1;
                        for j = 1:n_gram_size
                            testedHV = obj.encoding(test_data(i + j - 1, :), BaseHVs, LevelHVs, quantized_levels, clipping_encoding,quant_min, quant_max,  encoding_technique);
                            testedHV = obj.permutation(testedHV, j - 1);
                            n_gram_HV = obj.bundle(testedHV, n_gram_HV);
                        end
                        testedHV = obj.clip(n_gram_HV, quant_min, quant_max, clipping_encoding, n_gram_size);
                    end
                end

                for j = 1:num_classes
                    similarities(j) = obj.similarity(ClassHVs(j, :), testedHV);
%                     fprintf("Similarity[%d]: %d\n", j, similarities(j))
                end
                
                

                if strcmp(obj.HV_similarity, 'SIMIL_COS') ||strcmp(obj.HV_similarity, 'SIMI_DPROD') || strcmp(obj.density, 'SPARSE')
                    [~, estimated_class(i)] = max(similarities);
                else
                    [~, estimated_class(i)] = min(similarities);
                end
                

                if estimated_class(i) == actual_class(i)
                    correct = correct + 1;
                %else
                    %fprintf("Correct label: %d, estimated: %d\n", actual_class(i), estimated_class(i))
                end

                if i ~= 0 && mod(i, floor(num_test_samples / 10)) == 0 && verbose == 1
                    percentage = (i / num_test_samples) * 100;
                    fprintf('Progress: %.0f%% ---> accuracy: %.2f%%\n', ceil(percentage), (correct * 100 / i));
                end
            end

            if verbose == 1
                fprintf('\n\nAccuracy: %.2f%%\n', (correct * 100 / num_test_samples));
            end
            accuracy = correct * 100 / num_test_samples;
        end

        function [best_ClassHVs, predicted_label] = retrain(obj, retrain_data, retrain_labels, test_data, test_label, num_classes, quantized_levels, BaseHVs, LevelHVs, ClassHVs, clipping_encoding,quant_min, quant_max, verbose, n_gram, n_gram_size, encoding_technique, clipping_class, epochs, starting_accuracy, lr_max, beta_lr, learning_rate_decay)
            iterations = 0;
            num_retrain_samples = size(retrain_data, 1);

            accuracy_before = starting_accuracy;
            corrections = 10;
            best_ClassHVs = ClassHVs;
            beta = 0;
            best_epoch = 0;
            error_rate = zeros(1, beta_lr);
            bundled_labels = zeros(1, num_classes);
            best_bundled_labels = zeros(1, num_classes);
            learning_rate = lr_max;

            while iterations < epochs && corrections > 0
                if not(strcmp(learning_rate_decay, 'LR_CONSTANT'))
                    if beta == beta_lr
                        learning_rate = mean(error_rate) * 1000;
                        beta = 0;
                        if learning_rate > lr_max
                            learning_rate = lr_max;
                        end
                    end
                end

                encoded_HVs = zeros(1, obj.D);
                n_gram_HV = zeros(1, obj.D);
                temporal_HV = zeros(n_gram_size, obj.D);
                actual_class = 0;

                if strcmp(obj.HV_type, 'BIPOLAR') || strcmp(obj.density,'SPARSE')
                    similarities = zeros(1, num_classes);
                else
                    similarities = ones(1, num_classes);
                end

                corrections = 0;

                for i = 1:num_retrain_samples
                    if mod(i, floor(num_retrain_samples / 10)) == 0 && verbose == 1
                        percentage = (i / num_retrain_samples) * 100;
                        fprintf('Iteration: %d Progress: %.0f%%\n', i, ceil(percentage));
                    end

                    encoded_HVs = obj.encoding(retrain_data(i, :), BaseHVs, LevelHVs, quantized_levels, clipping_encoding,quant_min, quant_max,  encoding_technique);
                    actual_class = retrain_labels(i) + 1;

                    for j = 1:num_classes
                        similarities(j) = obj.similarity(ClassHVs(j, :), encoded_HVs);
                    end

                    estimated_class = -1;
                    if strcmp(obj.HV_similarity, 'SIMIL_COS') || strcmp(obj.HV_similarity, 'SIMI_DPROD') || strcmp(obj.density, 'SPARSE')
                        [~, estimated_class] = max(similarities);
                    else
                        [~, estimated_class] = min(similarities);
                    end

                    if actual_class ~= estimated_class
                        corrections = corrections + 1;
                        if strcmp(learning_rate_decay,'LR_DATA') || strcmp(learning_rate_decay, 'LR_HYBRID')
                            learning_rate_data = round((similarities(estimated_class) - similarities(actual_class)) * 100000);
                            if learning_rate_data > lr_max
                                learning_rate_data = lr_max;
                            end
                            if strcmp(learning_rate_decay,'LR_HYBRID')
                                learning_rate = learning_rate + learning_rate_data / 2;
                                if learning_rate > lr_max
                                    learning_rate = lr_max;
                                end
                            else
                                learning_rate = learning_rate_data;
                            end
                            ClassHVs(estimated_class, :) = ClassHVs(estimated_class, :) - learning_rate * encoded_HVs;
                            ClassHVs(actual_class, :) = ClassHVs(actual_class, :) + learning_rate * encoded_HVs;
                        else
                            ClassHVs(estimated_class, :) = ClassHVs(estimated_class, :) - learning_rate * encoded_HVs;
                            ClassHVs(actual_class, :) = ClassHVs(actual_class, :) + learning_rate * encoded_HVs;
                        end

                        bundled_labels(estimated_class) = bundled_labels(estimated_class) + 1 * learning_rate;
                        bundled_labels(actual_class) = bundled_labels(actual_class) + 1 * learning_rate;
                    end
                end

                [new_accuracy, new_predicted_label] = obj.predict(test_data, test_label, num_classes, quantized_levels, BaseHVs, LevelHVs, ClassHVs, clipping_encoding,  quant_min, quant_max, verbose, n_gram, n_gram_size, encoding_technique);
                if verbose == 1
                    fprintf('Epoch %d finished --> Corrections: %d Accuracy: %.2f%%\n', iterations, corrections, new_accuracy);
                end

                iterations = iterations + 1;

                if new_accuracy >= accuracy_before
                    if verbose == 1
                        fprintf('Accuracy improved --> Previous Accuracy: %.2f%% New accuracy: %.2f%%\n', accuracy_before, new_accuracy);
                    end
                    accuracy_before = new_accuracy;
                    predicted_label = new_predicted_label;
                    best_epoch = iterations;
                    best_ClassHVs = ClassHVs;
                    best_bundled_labels = bundled_labels;
                else
                    if verbose == 1
                        fprintf('Accuracy not improved --> Previous Accuracy: %.2f%% New accuracy: %.2f%%\n', accuracy_before, new_accuracy);
                    end
                end

                error_rate(beta + 1) = corrections * 100 / num_retrain_samples;
                if beta_lr ~= 1
                    beta = beta + 1;
                end
            end

            fprintf('------------------RETRAINING RECAP----------------------\n');
            fprintf('Retraining finished -->\n Starting accuracy: %.2f%%\n Best obtained accuracy: %.2f%%\n', starting_accuracy, accuracy_before);
            fprintf('Best epoch: %d\n', best_epoch);

            fprintf("Clipping class: %d\n", clipping_class)
            for i = 1:num_classes
                best_ClassHVs(i, :) = obj.clip(best_ClassHVs(i, :), quant_min, quant_max, clipping_class, best_bundled_labels(i));
            end
    
            fprintf('Applying clipping to ClassHVs and testing again...\n');

            predicted_label = new_predicted_label;
        end
    end
end

