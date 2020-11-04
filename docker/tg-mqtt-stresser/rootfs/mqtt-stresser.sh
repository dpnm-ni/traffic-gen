#!/bin/bash

IOT_DATA='{ "ID": 1, "message": "Hello there! This is an example IoT data. Goodbye and have fun!", "UUID": 4e9d613a-b8ae-47a2-b491-6a8cbd734d7d, "type": IoT, "date": "2019-12-31", "data": [ { "temp1": 30, "unit": C }, { "temp2": 31, "unit": C }, { "temp3": 100, "unit": F } ] }'

/bin/mqtt-stresser -constant-payload "$IOT_DATA" "$@"
