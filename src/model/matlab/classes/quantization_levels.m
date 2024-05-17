
function levelList = quantization_levels(min_value, max_value, levels)
    levelList = [];
    length = max_value - min_value;
    gap = length / levels;
    for level = 1:levels-1
        levelList = [levelList, min_value + (level-1) * gap];
    end
    levelList = [levelList, max_value];
end
