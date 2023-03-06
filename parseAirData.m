function data = parseAirData(rawData)
% PARSEAIRDATA parses raw data received from the Sniff Controller Air
% raw data is an int array received from the Air class
% pressure is in Pascal. Accelerometer data is in Arbitrary Units.
data.pressure = double(typecast(uint8(rawData(1:2)),'int16'))/60;%hardware scaling parameter
data.x = typecast(uint8(rawData(3:4)),'int16');
data.y = typecast(uint8(rawData(5:6)),'int16');
data.z = typecast(uint8(rawData(7:8)),'int16');
