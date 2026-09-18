#!/bin/bash

# Check if the CKAN__PLUGINS variable contains the word "activity"
if [[ $CKAN__PLUGINS == *"activity"* ]]; then
   echo "Activity plugin detected. Running database upgrade..."
   ckan --config=/srv/app/ckan.ini db upgrade -p activity
else
   echo "Activity plugin not found in CKAN__PLUGINS."
fi
