function monitorMqttConnection(mqttClient)
  mqttClient:on("connect", function(client)
    print ("MQTT connected")
  end)
  mqttClient:on("offline", function(client)
    print ("MQTT offline. Try recconect in 10 seconds.")
    tmr.create():alarm(10 * 1000, tmr.ALARM_SINGLE, function()
      connectMqttClient(mqttClient)
    end)
  end)
end

function connectMqtt()
  print("Connecting to MQTT.")
  mqttClient = mqtt.Client("clientid", 60)

  -- setup Last Will and Testament (optional)
  -- Broker will publish a message with qos = 0, retain = 0, data = "offline"
  -- to topic "/lwt" if client don't send keepalive packet
  mqttClient:lwt("/lwt", "offline", 0, 0)

  monitorMqttConnection(mqttClient)
  connectMqttClient(mqttClient)
end

function connectMqttClient(mqttClient)
  if (MQTT_CONFIGURATION.host == nil) then
    print("MQTT HOST: configuration missing. Please reach the support team.")
    return
  end
  if (MQTT_CONFIGURATION.port == nil) then
    print("MQTT PORT: configuration missing. Please reach the support team.")
    return
  end
  if (MQTT_CONFIGURATION.isSecure == nil) then
    print("MQTT ISSECURE: configuration missing. Please reach the support team.")
    return
  end
  mqttClient:connect(MQTT_CONFIGURATION.host, MQTT_CONFIGURATION.port, MQTT_CONFIGURATION.isSecure, function(client)
    print("MQTT connected")
  end,
  function(client, reason)
    print("failed to connect to " .. MQTT_CONFIGURATION.host .. ":" .. MQTT_CONFIGURATION.port .. ". reason: " .. reason)
    print("Try recconect in 10 seconds.")
    tmr.create():alarm(10 * 1000, tmr.ALARM_SINGLE, function()
      connectMqttClient(mqttClient)
    end)
  end)
end
