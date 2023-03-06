classdef Air
    % AIR class that handles connection to Sniff Controller Air by Sniff
    % Logic Ltd. Communication is via Bluetooth Low Energy (BLE) supported
    % in Matlab R2019b and up, Windows 10 and up, Bluetoth 4.2 and up.
    properties
        device %ble device
        dataChar %data characteristic
        subscribed = false; % are we subscribed?
        freqChar %frequency characteristic
        batteryChar %battery level characteristic
    end
    methods
        function obj = connect(obj,identfier)
            % CONNECT connect to an Air device via BLE.
            % connect("device name") will connect to the Air with the the
            % given name. If it could not find a device with the given
            % name, will throw an error.
            % connect("address") will connect to the Air with the given
            % address. If it could not find a device witht he given
            % address, will throw an error.
            % 
            % This is supported in Matlab R2019b and up. Please ensure your
            % computer supports BLE and that the BLE is on.
             obj.device = ble(identfier);
             obj.dataChar = characteristic(obj.device,"00000000-C221-03D1-2336-9112FD7A556B","00000001-C221-03D1-2336-9112FD7A556B");
             obj.freqChar = characteristic(obj.device,"00000000-C221-03D1-2336-9112FD7A556B","00000010-C221-03D1-2336-9112FD7A556B");
             obj.batteryChar = characteristic(obj.device,"Battery Service","Battery Level");
        end
        
        function data = readData(obj)
            % READDATA reads one value of data from Air, parses it and
            % returns it.
            rawData = read(obj.dataChar);
            data = parseAirData(rawData);
        end
            
        
        function obj = subscribe(obj,func)
            % SUBSCRIBE subscribes to updates in data. When new data
            % arrives it will be sent to the given function.
            obj.dataChar.DataAvailableFcn = func;
            obj.subscribed = true;
        end
        
        function obj = unsubscribe(obj)
            % UNSUBSCRIBE stops subscribing to changes in data.
            unsubscribe(obj.dataChar);
            obj.subscribed = false;
        end
        
        function changeName(obj, newName)
            % CHANGENAME changes the name of the Air.
            % a.changename(newName) will set this Air to have newName.
            % newName MUST start with "Air" for compatibility with our
            % software. 
            % IMPORTANT: In order to see the name update you need to 
            % disconnect and run blelist again.
            if (~newName.startsWith("Air"))
                error("Name of Air device must start with 'Air' for compatibility reasons");
            end
            if (obj.subscribed)
                error("Cannot change name while subscribed to data. Please unsubscribe and try again");
            end
            c = characteristic(obj.device,"00000000-C221-03D1-2336-9112FD7A556C","00000001-C221-03D1-2336-9112FD7A556C");
            write(c,newName);
        end
        
        function batteryLevel  = getBattery(obj)
            % GETBATTERY returns the currnent battery level in percent
            batteryLevel = read(obj.batteryChar);
        end
        
        function rate = getRate(obj)
            % GETRATE returns the current sampling rate of the Air
            % rate = a.getRate()
            rate = read(obj.freqChar);
        end
        
        function changeRate(obj, newRate)
            % CHANGERATE changes the sampling rate of the air
            % a = a.changeRate(newRate) will change the sampling rate to 
            % newRate. Note that rates above 15Hz have not been tested and
            % might be unreliable or unstable. Rates above 200Hz are not
            % supported at all.
            % 
            % IMPORTANT: rate is not persistent. If you power off the Air
            % and power it on again, it will boot at hte default rate of
            % 6Hz.
            if (obj.subscribed)
                error("Cannot change name while subscribed to data. Please unsubscribe and try again");
            end
            if (newRate > 15)
                warning("Air has not been tested at higher rates and might be unstable or unreliable");
            end
            write(obj.freqChar,newRate);
        end
        
        function obj = disconnect(obj)
            % DISCONNECT disconnects to the Air device
            obj.device = '';
            obj.freqChar = '';
            obj.batteryChar = '';
            obj.dataChar = '';
        end
    end
end