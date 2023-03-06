%% scan for ble devices
blelist;

%% create Air object
a = Air();

%% connect to device
a = a.connect("Air");
% make sure that LED in AIR is constant and not blinking before continuing

%% get battery level
fprintf("battery level is %d%%\n",a.getBattery());

%% get current rate
fprintf("current rate is: %d Hz\n", a.getRate());

%% subscribe to data with function displayData
a = a.subscribe(@displayData);

%% unsubscribe
a = a.unsubscribe();

%% set frequency, verify frequency and resubscribe
a.changeRate(6);
fprintf("rate is now %d Hz \n",a.getRate());
a = a.subscribe(@displayData);

%% unsubscribe
a = a.unsubscribe();

%% set name
a.changeName("AirTest1");

%% disconnect
a = a.disconnect();

%% verify changed name
blelist
