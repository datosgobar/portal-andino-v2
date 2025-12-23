#!/bin/bash

if echo "$CKAN__PLUGINS" | grep -qw "xloader"; then
   # Xloader settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKANEXT__XLOADER__API_TOKEN" ] ; then
      echo "Set up ckanext.xloader.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckanext.xloader.api_token=$(ckan -c $CKAN_INI user token add ckan_admin xloader | tail -n 1 | tr -d '\t')"
      ckan config-tool $CKAN_INI "ckanext.xloader.jobs_db.uri = $CKAN_SQLALCHEMY_URL"
   fi
else
   echo "Not configuring Xloader"
fi
