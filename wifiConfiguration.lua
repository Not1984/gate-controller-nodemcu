local firstSuccessConnection = true

function monitorWifi(connectMqtt)
  wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
    print("\n\tSTA - CONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
    T.BSSID.."\n\tChannel: "..T.channel)
  end)

  wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(T)
    print("\n\tSTA - DISCONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
    T.BSSID.."\n\treason: "..T.reason)
    end)

  wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, function(T)
    print("\n\tSTA - AUTHMODE CHANGE".."\n\told_auth_mode: "..
    T.old_auth_mode.."\n\tnew_auth_mode: "..T.new_auth_mode)
    end)

  wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
    print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..
    T.netmask.."\n\tGateway IP: "..T.gateway)
    if (firstSuccessConnection == true) then
      connectMqtt()
      firstSuccessConnection = false
    end
  end)

  wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, function()
    print("\n\tSTA - DHCP TIMEOUT")
    end)

  wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, function(T)
    print("\n\tAP - STATION CONNECTED".."\n\tMAC: "..T.MAC.."\n\tAID: "..T.AID)
    end)

  wifi.eventmon.register(wifi.eventmon.AP_STADISCONNECTED, function(T)
    print("\n\tAP - STATION DISCONNECTED".."\n\tMAC: "..T.MAC.."\n\tAID: "..T.AID)
    end)

  wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, function(T)
    print("\n\tAP - PROBE REQUEST RECEIVED".."\n\tMAC: ".. T.MAC.."\n\tRSSI: "..T.RSSI)
    end)

  wifi.eventmon.register(wifi.eventmon.WIFI_MODE_CHANGED, function(T)
    print("\n\tSTA - WIFI MODE CHANGED".."\n\told_mode: "..
    T.old_mode.."\n\tnew_mode: "..T.new_mode)
    end)
end

function connectWifi()
  print("Connecting to wifi.")
  if (WIFI_CONFIGURATION.ssid == nil) then
    print("SSID configuration missing. Please reach the support team.")
    return
  end
  -- connect to WiFi access point
  wifi.setmode(wifi.STATION)
  station_cfg={}
  station_cfg.ssid = WIFI_CONFIGURATION.ssid
  station_cfg.pwd = WIFI_CONFIGURATION.password
  station_cfg.save = false
  wifi.sta.config(station_cfg)
end
