function [total_calories, met_value] = calculateCalories(mode, duration_seconds, body_weight_kg)
    % This function calculates METs and calories burned based on the activity.

    % --- 1. Assign MET value based on detected mode ---
    switch mode
        case 'running'
            met_value = 7.0;
        case 'stairs' % Assuming a stairs file would be detected as 'running'
            met_value = 5.0; 
        case 'walking'
            met_value = 3.5;
        case 'stabilized'
            met_value = 1.0; % Resting MET value
        otherwise
            met_value = 3.5; % Default to walking
    end

    % --- 2. Calculate Calories Burned ---
    duration_minutes = duration_seconds / 60;
    
    % Standard formula for calorie calculation
    calories_per_minute = (met_value * body_weight_kg * 3.5) / 200;
    
    total_calories = calories_per_minute * duration_minutes;
end