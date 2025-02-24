#!/bin/bash
PWD=$(pwd)
JOIN_EUI=$(grep ^LORA_JOIN_EUI bridge/.env | cut -d "=" -f 2 | tail -n1)
DEV_EUI=$(grep ^LORA_DEV_EUI bridge/.env | cut -d "=" -f 2 | tail -n1)
DEV_KEY=$(grep ^LORA_DEV_KEY bridge/.env | cut -d "=" -f 2 | tail -n1)

mkdir -p bridge/bridge-lorawan-tx/rpi_flashing/data

FN=bridge/bridge-lorawan-tx/rpi_flashing/data/secrets.txt
echo $DEV_KEY | tac -rs .. | echo "$(tr -d '\n')" > $FN
echo $JOIN_EUI | tac -rs .. | echo "$(tr -d '\n')" >> $FN
echo $DEV_EUI | tac -rs .. | echo "$(tr -d '\n')" >> $FN

vi $FN -c "set ff=dos" -c ":wq"

cd bridge/bridge-lorawan-tx/rpi_flashing
./spiffs_config.sh
./flash_command.sh

cd $PWD

rm -rf bridge/bridge-lorawan-tx/rpi_flashing/data
rm -f bridge/bridge-lorawan-tx/rpi_flashing/spiffs.bin
