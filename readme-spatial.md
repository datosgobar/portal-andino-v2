# Spatial

Soporte de búsqueda espacial vía [ckanext-spatial](https://github.com/ckan/ckanext-spatial) (facet e índice geográfico en Solr) y mapa de extensión vía [ckanext-spatial-widget-ar](https://github.com/datosgobar/ckanext-spatial-widget-ar).

## Plugins

En `CKAN__PLUGINS` (`.env`): `spatial_metadata spatial_query resource_proxy geo_view geojson_view wmts_view shp_view spatial_widget_ar`.

Si además se harvestea metadata espacial (CSW), sumar `csw_harvester` (no está habilitado por defecto).

## Índice Solr

`ckanext-spatial` necesita un campo espacial que el schema base de Solr no trae. El servicio `solr-init` (en `docker-compose.yml` y `docker-compose.dev.yml`) lo agrega en el arranque, contra el core `ckan`, vía la Schema API:

- Field type `location_rpt` (`SpatialRecursivePrefixTreeFieldType`, factory `JTS`, `autoIndex=true`)
- Field `spatial_geom` (tipo `location_rpt`, `indexed+stored+multiValued`)

`solr-init` reintenta hasta que el core `ckan` responde `STATUS`, aplica ambos cambios (ignora error si ya existen) y recarga el core. Es un contenedor de un solo uso (`restart: "no"`); no hace falta correrlo manualmente salvo que se reconstruya Solr desde cero.

## Configuración (.env)

```
CKANEXT__SPATIAL__SEARCH_BACKEND=solr-spatial-field
CKANEXT__SPATIAL__SPATIAL_FIELD=spatial_geom
CKAN__SPATIAL__SRID=4326

CKANEXT__SPATIAL__COMMON_MAP__TYPE=custom
CKANEXT__SPATIAL__COMMON_MAP__CUSTOM__URL=https://wms.ign.gob.ar/geoserver/gwc/service/tms/1.0.0/capabaseargenmap@EPSG%3A3857@png/{z}/{x}/{-y}.png
CKANEXT__SPATIAL__COMMON_MAP__ATTRIBUTION=Instituto Geográfico Nacional + OpenStreetMap

CKANEXT__RESOURCEPROXY__ENABLED=true
CKANEXT__RESOURCEPROXY__MAXFILESIZE=5000000
CKANEXT__RESOURCEPROXY__TIMEOUT=10
```

El mapa base usa las teselas del IGN (Instituto Geográfico Nacional).

## spatial-widget-ar

Mapa de "Extensión espacial" en el sidebar del dataset. Configuración:

```
CKAN__EXTENSIONS__SPATIAL_WIDGET_AR__DEFAULT_BBOX="-74,-55,-53,-21"
CKAN__EXTENSIONS__SPATIAL_WIDGET_AR__DEFAULT_CENTER="-64,-34"
CKAN__EXTENSIONS__SPATIAL_WIDGET_AR__DEFAULT_ZOOM="4"
```

El bbox/center por defecto cubre el territorio argentino continental.
