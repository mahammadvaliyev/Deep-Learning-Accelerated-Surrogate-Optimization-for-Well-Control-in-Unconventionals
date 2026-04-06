% List of struct names corresponding to the loaded files
structNames = {
    'history_linear_40', 
    'history_linear_90', 
    'history_linear_140', 
    'history_piece_40', 
    'history_piece_90', 
    'history_piece_140', 
    'history_comb_40', 
    'history_comb_90', 
    'history_comb_140'
};

% Loop through each struct
for i = 1:length(structNames)
    % Access the struct variable from the workspace
    structData = eval(structNames{i});
    
    % Extract the last row of 'x'
    lastRow = structData.x(end, :);
    
    % Rename variable by replacing 'history_' with 'x_' and adding '_v2'
    newVariableName = strcat('x_', strrep(structNames{i}, 'history_', ''), '_v2');
    
    % Create the filename for saving
    saveFileName = strcat(newVariableName, '.mat');
    
    % Assign the last row to a new variable with the new name in the workspace
    assignin('base', newVariableName, lastRow);
    
    % Save the new variable to the .mat file
    save(saveFileName, newVariableName);
end
