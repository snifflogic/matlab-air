function displayData(src,event)
    % DISPLAYDATA example function to use with subscribe callback
    % receives the data, parses it, and displays it.
    
    % matlab recommends to read oldest in case of flushing problems
    [data,timestamp] = read(src,'oldest');
    % parse data from device
    data = parseAirData(data);
    % display data
    disp(data.pressure)
end