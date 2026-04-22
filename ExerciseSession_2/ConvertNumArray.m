function [species1] = ConvertNumArray(species)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
unique_labels = unique(species);

for i=1:length(species)
    for j=1:length(unique_labels)
        if strcmp(string(unique_labels{j}), string(species{i}))
            species{i}=j;
        end
    end
end

species1 = cell2mat(species);

end