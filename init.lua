require("configuration");
require("wifiConfiguration");
require("mqttConfiguration");

print("Start inicialization Gate Controller")
connectWifi()
monitorWifi(connectMqtt)
