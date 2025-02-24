#!/bin/sh
docker container stop bridge-lorawan-interface-1 2>/dev/null
sleep 2
esptool.py --chip esp32 --before default_reset run
sleep 2
docker container start bridge-lorawan-interface-1 2>/dev/null