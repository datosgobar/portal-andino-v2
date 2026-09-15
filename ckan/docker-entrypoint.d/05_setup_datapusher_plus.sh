#!/bin/bash

if [[ $CKAN__PLUGINS == *"datapusher_plus"* ]]; then
   # Datapusher settings have been configured in the .env file
   # Set API token if necessary
   #exec ckan ckan -c /etc/ckan/default/ckan.ini db upgrade -p datapusher_plus
   ckan --config=/srv/app/ckan.ini db upgrade -p datapusher_plus
   if [ -z "$CKANEXT__DATAPUSHER_PLUS__API_TOKEN" ] ; then
      echo "Set up ckan.datapusher_plus.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckan.datapusher_plus.api_token=$(ckan -c $CKAN_INI user token add ckan_admin datapusher_plus | tail -n 1 | tr -d '\t')"
   fi
   if [ -n "$CKAN_DATASTORE_WRITE_URL" ] ; then
      echo "Set up ckan.datastore.write_url in the CKAN config file"
      ckan config-tool $CKAN_INI "ckan.datastore.write_url=$CKAN_DATASTORE_WRITE_URL"
   fi
else
   echo "Not configuring DataPusher"
fi
