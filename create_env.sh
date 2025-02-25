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
HTTP_PASS=$(tr -cd "[:graph:]" < /dev/urandom | tr -d \' | head -c 20)
HTPASSWD=$(htpasswd -nbB $HTTP_USER $HTTP_PASS)
echo "BASIC_AUTH='$HTPASSWD'" >> $FN

echo "Your credentials for the webinterface are"
echo "username: $HTTP_USER"
echo "password: $HTTP_PASS"
echo "$(tput setaf 1)You need to remember them, storing them in a $(tput bold)password safe$(tput sgr0 setaf 1) is recommended!$(tput sgr0)"

echo "NODERED_HOST=node-red" >> $FN
echo "NODERED_PORT=1880" >> $FN
echo "SERIAL_PORT=/dev/ttyACM0" >> $FN

GID_DOCKER=$(getent group docker | cut -d ":" -f 3)
echo "GID_DOCKER=$GID_DOCKER" >> $FN

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

CHIRPSTACK_USER=admin
CHIRPSTACK_PASS=$(tr -cd "[:graph:]" < /dev/urandom | tr -d \' | head -c 20)
CHIRPSTACK_HASH=$(python3 -c "import os;import hashlib;import base64;iterations=210000;dklen=64;salt=os.urandom(32);print(f'\$pbkdf2-sha512\$i={iterations},l={dklen}\${base64.b64encode(salt).decode().replace("=","")}\${base64.b64encode(hashlib.pbkdf2_hmac('sha512','$CHIRPSTACK_PASS'.encode(), salt,iterations=iterations,dklen=dklen)).decode().replace("=","")}')")

echo "CHIRPSTACK_USER=$CHIRPSTACK_USER" >> $FN
echo "CHIRPSTACK_PASSWORD='$CHIRPSTACK_PASS'" >> $FN
echo "CHIRPSTACK_HASH='$CHIRPSTACK_HASH'" >> $FN

echo "Your credentials for the chirpstack webinterface are"
echo "username: $CHIRPSTACK_USER"
echo "password: $CHIRPSTACK_PASS"
echo "$(tput setaf 1)You need to remember them, storing them in a $(tput bold)password safe$(tput sgr0 setaf 1) is recommended!$(tput sgr0)"

COUCHDB_PASSWORD=$(tr -cd "[:graph:]" < /dev/urandom | tr -d \' | head -c 20)

echo "COUCHDB_USER=admin" >> $FN
echo "COUCHDB_PASSWORD='$COUCHDB_PASSWORD'" >> $FN
echo "COUCHDB_PORT=5984" >> $FN
echo "COUCHDB_DB=mydb" >> $FN

GID_SPI=$(getent group spi | cut -d ":" -f 3)
GID_GPIO=$(getent group gpio | cut -d ":" -f 3)
echo "GID_SPI=$GID_SPI" >> $FN
echo "GID_GPIO=$GID_GPIO" >> $FN