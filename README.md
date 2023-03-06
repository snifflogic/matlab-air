# matlab-air
Matlab SDK for communicating with the Sniff Controller Air of Sniff Logic

# Usage
Clone this repo to your computer. Add the folder to your Matlab Path using `addpath("c:\path\to\MyFolder")`.

- `Air.m` holds the class for communicating with the air. 
- `sniffControllerAirExample.m` demonstrates the usage of Air class. 
- `parseAirData` parses the raw data received from the Air into a struct with pressure (Pa) and X,Y,Z accelerometer data (A.U.).
- `displayData` is an example function to use with the `subscribe` callback, see example in `sniffControllerAirExample.m`

# Troubleshooting
 - Please make sure BLE is enabled on your computer. BLE is not the same as Bluetooth.
 - Classes in Matlab need to be returned. Therefore the below code will not work:
 ```
 a = Air();
 a.connect("Air");
 batteryLevel = a.getBattery();
 ```
 but this code will:
 ```
 a = Air();
 a = a.connect("Air");%<---Note the 'a = '
 batteryLevel = a.getBattery();
 ```

# Bugs
If you've discovered a bug, please open an issue. Write what is your device and operating system, what version of 
Matlab you're using, and what version of Bluetooth is in your computer.

# Contribute
Done something cool that will help others? Please feel free to submit a pull request.
