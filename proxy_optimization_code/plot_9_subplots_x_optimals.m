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

% Determine the number of subplots
numRows = 3;
numCols = 3;

% Create a new figure
figure;

% Loop through each struct and create a subplot
for i = 1:length(structNames)
    % Access the struct variable from the workspace
    structData = eval(structNames{i});
    
    % Extract the last row of 'x'
    lastRow = structData.x(end, :);
    
    % Determine the title for the subplot
    titlePart = strrep(structNames{i}, 'history_', '');
    
    % Create subplot
    subplot(numRows, numCols, i);
    plot(lastRow);
    title(titlePart);
    xlabel('Variable Index');
    ylabel('Value');
    grid on; % Add grid for better visibility
end

% Adjust layout to prevent overlapping
tight_layout();
