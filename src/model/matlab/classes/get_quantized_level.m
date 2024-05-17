
function quantized_level = get_quantized_level(value, quantization_levels)
    quantized_level = 0;
    for i = 1:numel(quantization_levels)
        if value <= quantization_levels(1)
            quantized_level = 0;
            return;
        end
        if value <= quantization_levels(i)
            quantized_level = i - 1;
            return;
        end
    end
    quantized_level = numel(quantization_levels) - 1;
end