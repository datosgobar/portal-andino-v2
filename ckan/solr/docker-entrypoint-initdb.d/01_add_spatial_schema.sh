#!/bin/bash
set -e

# Esperar a que Solr esté listo
until curl -s "http://localhost:8983/solr/ckan/admin/ping" > /dev/null 2>&1; do
  echo "Waiting for Solr..."
  sleep 2
done

echo "Adding spatial field type..."
curl -X POST -H 'Content-type:application/json' \
  'http://localhost:8983/solr/ckan/schema' -d '{
  "add-field-type":{
    "name":"location_rpt",
    "class":"solr.SpatialRecursivePrefixTreeFieldType",
    "spatialContextFactory":"JTS",
    "autoIndex":"true",
    "validationRule":"repairBuffer0",
    "distErrPct":"0.025",
    "maxDistErr":"0.001",
    "distanceUnits":"kilometers"
  }
}' 2>/dev/null || echo "Field type already exists"

echo "Adding spatial field..."
curl -X POST -H 'Content-type:application/json' \
  'http://localhost:8983/solr/ckan/schema' -d '{
  "add-field":{
    "name":"spatial_geom",
    "type":"location_rpt",
    "indexed":true,
    "stored":true,
    "multiValued":true
  }
}' 2>/dev/null || echo "Field already exists"

echo "Spatial schema setup complete"