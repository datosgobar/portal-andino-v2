#!/bin/bash

if echo "$CKAN__PLUGINS" | grep -qw "ckan_harvester"; then
   # Harvester settings have been configured in the .env file
   echo "Upgrade db harvester"
   ckan --config=/srv/app/ckan.ini db upgrade -p harvest
else
   echo "Not configuring Harvester"
fi