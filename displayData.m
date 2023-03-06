function displayData(src,event)
    % matlab recommends to read oldest in case of flushing problems
    [data,timestamp] = read(src,'oldest');
    % raw data from device
    data = parseAirData(data);
    % scaled data
    disp(data.pressure)
end