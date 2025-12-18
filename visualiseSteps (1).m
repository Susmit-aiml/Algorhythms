function visualiseSteps(accel_data, peak_height, peak_prominence)
    mag = sqrt(sum(accel_data{:,:}.^2, 2));
    
    figure;
    findpeaks(mag, 'MinPeakHeight', peak_height, 'MinPeakProminence', peak_prominence);
    
    title_str = sprintf('Step Visualization (Height=%.2f, Prominence=%.2f)', peak_height, peak_prominence);
    title(title_str);
    xlabel('Data Samples');
    ylabel('Acceleration Magnitude');
end