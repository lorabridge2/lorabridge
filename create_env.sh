#!/bin/bash

# bridge device
FN=bridge/.env

echo "MQTT_USERNAME=lorabridge" > $FN
MQTT_PASS=$(tr -cd "[:alnum:]" < /dev/urandom | head -c 20)
echo "MQTT_PASSWORD=$MQTT_PASS" >> $FN
echo "MQTT_HOST=mqtt" >> $FN
echo "MQTT_PORT=1883" >> $FN
echo "MQTT_TOPIC=zigbee2mqtt" >> $FN

echo "REDIS_HOST=redis" >> $FN
echo "REDIS_PORT=6379" >> $FN
echo "REDIS_DB=0" >> $FN
echo "REDIS_LIST=lorabridge_data" >> $FN

DEV_EUI=$(tr -cd "[:xdigit:]" < /dev/urandom | head -c 16)
echo "LORA_DEV_EUI=${DEV_EUI^^}" >> $FN

DEV_KEY=$(tr -cd "[:xdigit:]" < /dev/urandom | head -c 32)
echo "LORA_DEV_KEY=${DEV_KEY^^}" >> $FN

JOIN_EUI=$(tr -cd "[:xdigit:]" < /dev/urandom | head -c 16)
echo "LORA_JOIN_EUI=${JOIN_EUI^^}" >> $FN

HTTP_USER=admin
HTTP_PASS=$(tr -cd "[:graph:]" < /dev/urandom | head -c 20)
HTPASSWD=$(htpasswd -nbB $HTTP_USER $HTTP_PASS)
echo "BASIC_AUTH='$HTPASSWD'" >> $FN

echo "Your credentials for the webinterface are"
echo "username: $HTTP_USER"
echo "password: $HTTP_PASS"
echo "$(tput setaf 1)You need to remember them, storing them in a $(tput bold)password safe$(tput sgr0 setaf 1) is recommended!$(tput sgr0)"

echo "NODERED_HOST=node-red" >> $FN
echo "NODERED_PORT=1880" >> $FN
echo "SERIAL_PORT=/dev/ttyACM0" >> $FN

# gateway device
FN=gateway/.env

# echo "CHIRP_TOPIC=application/00000000-0000-0000-0000-000000000001/device" > $FN
echo "MQTT_USERNAME=lorabridge" >> $FN
MQTT_PASS=$(tr -cd "[:alnum:]" < /dev/urandom | head -c 20)
echo "MQTT_PASSWORD=$MQTT_PASS" >> $FN
echo "MQTT_HOST=mqtt" >> $FN
echo "MQTT_PORT=1883" >> $FN
# echo "MQTT_TOPIC=zigbee2mqtt" >> $FN

echo "REDIS_HOST=redis" >> $FN
echo "REDIS_PORT=6379" >> $FN
echo "REDIS_DB=0" >> $FN

echo "DEV_MAN_TOPIC=devicemanager" >> $FN
echo "DEV_DISCOVERY_TOPIC=lorabridge/discovery" >> $FN
echo "DEV_STATE_TOPIC=lorabridge/state" >> $FN

echo "CHIRPSTACK_DEV_EUI=\x${DEV_EUI^^}" >> $FN
echo "CHIRPSTACK_DEV_KEY=\x${DEV_KEY^^}" >> $FN
echo "CHIRPSTACK_API_SECRET=$(openssl rand -base64 32)" >> $FN
echo "CHIRPSTACK_USER=admin" >> $FN
echo "CHIRPSTACK_PASSWORD=admin" >> $FN

echo "COUCHDB_USER=admin" >> $FN
echo "COUCHDB_PASSWORD=couchdb" >> $FN
echo "COUCHDB_PORT=5984" >> $FN
echo "COUCHDB_DB=mydb" >> $FN