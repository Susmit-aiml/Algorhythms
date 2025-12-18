function total_seconds = calculateDuration(sensor_timetable)
    % This function calculates the total duration in seconds from a timetable.

    % Safety check for valid data
    if ~istimetable(sensor_timetable) || height(sensor_timetable) < 2
        total_seconds = 0;
        return;
    end
    
    % Get the time vector from the timetable data
    % FIX: The variable is named 'Timestamp', not 'Time'.
    time_vector = sensor_timetable.Timestamp;
    
    % Calculate the difference between the last and first timestamp
    duration_object = time_vector(end) - time_vector(1);
    
    % Convert the result to total seconds
    total_seconds = seconds(duration_object);
end