function plotRouteMap(position_data, total_distance)
    % This function creates an advanced heat map with a continuous, color-changing line.

    % --- Safety Check ---
    if height(position_data) < 2 || ~ismember('speed', position_data.Properties.VariableNames)
        disp('Not enough data or speed information is missing, cannot plot heat map.');
        return;
    end

    figure;
    lat = position_data.latitude;
    lon = position_data.longitude;
    speed_data = position_data.speed; % Speed in meters/second

    % --- Advanced Plotting Logic ---
    cmap = colormap('jet'); % Get the 'jet' colormap (blue-to-red)
    
    % Normalize speed data to map to colors
    min_speed = min(speed_data);
    max_speed = max(speed_data);
    if max_speed == min_speed, max_speed = min_speed + 1; end % Avoid division by zero
    
    hold on; % Hold the plot to draw multiple segments
    
    % Loop through and draw each line segment with its own color
    for i = 1:length(lon)-1
        % Determine color for the segment based on the speed at its start
        normalized_speed = (speed_data(i) - min_speed) / (max_speed - min_speed);
        color_index = 1 + floor(normalized_speed * (size(cmap, 1) - 1));
        
        % Plot just this one segment
        plot(lon(i:i+1), lat(i:i+1), 'LineWidth', 2, 'Color', cmap(color_index, :));
    end
    
    % Add the color bar to act as a legend
    h = colorbar;
    ylabel(h, 'Speed (m/s)');
    caxis([min_speed, max_speed]); % Set colorbar limits to match actual speed
    
    % Add Start and End markers
    plot(lon(1), lat(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k');
    plot(lon(end), lat(end), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
    
    hold off;
    
    % --- Final Touches ---
    xlabel('Longitude');
    ylabel('Latitude');
    title_str = sprintf('Workout Heat Map - Total Distance: %.1f meters', total_distance);
    title(title_str);
    grid on;
    axis equal;
    set(gca, 'Color', [0.8 0.8 0.8]); % Add a gray background for contrast
end