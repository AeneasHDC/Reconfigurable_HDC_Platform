classdef report
    properties
        problem_type
        rep
    end
    
    methods
        function obj = report(problem_type)
            obj.problem_type = problem_type;
            obj.rep = struct();
        end
        
        function generate_report(obj, y_test, y_pred)
            binary_labels_test = binarize_labels(y_test);
            binary_labels_pred = binarize_labels(y_pred);
            
            obj.rep.accuracy = sum(y_test == y_pred) / numel(y_test);
            
            if strcmp(obj.problem_type, 'binary')
                obj.rep.precision = precision_score(binary_labels_test, binary_labels_pred);
                obj.rep.recall = recall_score(binary_labels_test, binary_labels_pred);
                obj.rep.f1_score = f1_score(binary_labels_test, binary_labels_pred);
                obj.rep.roc_auc = roc_auc_score(binary_labels_test, binary_labels_pred);
            elseif strcmp(obj.problem_type, 'multiclass')
                obj.rep.precision = precision_score(binary_labels_test, binary_labels_pred, 'macro');
                obj.rep.recall = recall_score(binary_labels_test, binary_labels_pred, 'macro');
                obj.rep.f1_score = f1_score(binary_labels_test, binary_labels_pred, 'macro');
                obj.rep.roc_auc = roc_auc_score(binary_labels_test, binary_labels_pred, 'macro');
            end
            
            obj.rep.confusion_matrix = confusion_matrix(y_test, y_pred);
        end
        
        function save_report(obj, filename)
            json_str = jsonencode(obj.rep);
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', json_str);
            fclose(fid);
        end
    end
end

function binary_labels = binarize_labels(labels)
    unique_labels = unique(labels);
    num_classes = numel(unique_labels);
    binary_labels = zeros(numel(labels), num_classes);
    
    for i = 1:num_classes
        binary_labels(labels == unique_labels(i), i) = 1;
    end
end
