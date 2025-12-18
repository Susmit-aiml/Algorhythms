function flights_climbed = countStairs(position_data)
    % This is the corrected, more robust version of the stair counting function.

    % --- 1. Safety Check ---
    if height(position_data) < 2 || ~ismember('altitude', position_data.Properties.VariableNames)
        flights_climbed = 0;
        return;
    end

    % --- 2. NEW LOGIC: Calculate Total Elevation Gain ---
    % Get the altitude data from the input table.
    altitude = position_data.altitude;
    
    % Smooth the altitude data first to remove high-frequency noise.
    altitude_smoothed = smoothdata(altitude, 'gaussian', 10);
    
    % Find the lowest and highest points in the entire session.
    min_altitude = min(altitude_smoothed);
    max_altitude = max(altitude_smoothed);
    
    % The total ascent is the difference between the highest and lowest points.
    % This method is robust and ignores small up-and-down fluctuations.
    total_ascent_meters = max_altitude - min_altitude;
    
    % --- 3. Convert Ascent to Flights ---
    % Define a standard flight of stairs as 3 meters.
    meters_per_flight = 3; 
    
    % Divide the total ascent by the height of one flight.
    flights_climbed = floor(total_ascent_meters / meters_per_flight);
end