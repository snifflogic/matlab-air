function data = parseAirData(rawData)
data.pressure = double(typecast(uint8(rawData(1:2)),'int16'))/60;
data.x = typecast(uint8(rawData(3:4)),'int16');
data.y = typecast(uint8(rawData(5:6)),'int16');
data.z = typecast(uint8(rawData(7:8)),'int16');
