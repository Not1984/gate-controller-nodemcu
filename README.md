# NodeMCU Gate controller

This project will produce a gate controller that uses NodeMCU v3 and communicates via MQTT witha open message protocol.

## Hardware

This project use ESP8266 and has two sensors and one remote control to operate the gate.

## Messages MQTT

The device will be connected in a MQTT broker and will produce message in the a channel defined per device. A subscription in a channel will per device configuration and the pessages will be as follow described.

### Receive messages

- Stop
- Open
- Close
- UpdateStatus

### Sending message

- Opened
- Closed
- Opening
- Closing

the messages will be encoded in a protobuf.

## External Resources

https://github.com/marcelstoer/docker-nodemcu-build
https://nodemcu.readthedocs.io/en/master/
