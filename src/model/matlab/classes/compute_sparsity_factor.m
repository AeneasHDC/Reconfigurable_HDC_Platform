function sparsity_factor = compute_sparsity_factor(vector)
    total_elements = numel(vector);
    num_ones = sum(vector == 1);
    sparsity_factor = num_ones / total_elements;
end