# Harvest

Cosecha de catálogos externos vía [ckanext-harvest](https://github.com/ckan/ckanext-harvest) + los harvesters de [ckanext-gobar-harvest](https://github.com/datosgobar/ckanext-gobar-harvest): `xlsx_harvester` (catalog.xlsx estilo datos.gob.ar), `gobar_ckan_harvester` (Andinos viejos, ~CKAN 2.6) y `ckan_harvester` (instancias CKAN nativas).

## Plugins y cola de mensajes

En `CKAN__PLUGINS`: `harvest gobar_ckan_harvester ckan_harvester xlsx_harvester`.

La cola de harvest usa Redis en vez de RabbitMQ:

```
CKAN__HARVEST__MQ__TYPE=redis
CKAN__HARVEST__MQ__HOSTNAME=redis
CKAN__HARVEST__MQ__PORT=6379
CKAN__HARVEST__MQ__REDIS_DB=1
```

## Setup en el entrypoint

`ckan/docker-entrypoint.d/03_setup_harvester.sh` corre `ckan db upgrade -p harvest` al arrancar el contenedor, si `ckan_harvester` está en `CKAN__PLUGINS`.

## Consumers y cron

Los jobs de harvest se procesan en el servicio `ckan-worker` (`docker-compose.yml` / `docker-compose.dev.yml`), que arranca `supervisord` con los procesos `ckan_gather_consumer` y `ckan_fetch_consumer`.

`ckan-worker` monta `ckan/cron_ckan` como crontab de `root` (prod) / `ckan` (dev):

```
*/5 * * * * ckan -c /srv/app/ckan.ini harvester run >> /var/log/ckan_harvester.log 2>&1
```

`harvester run` despacha a la cola los jobs en estado `New` de las fuentes activas; el consumer los toma y ejecuta el import. En dev, si el contenedor se levanta sin `ckan-worker` (o `supervisord` no llegó a arrancar), los jobs quedan encolados sin procesarse — confirmar `supervisorctl status` dentro del contenedor.

## Alta de una fuente

Una fuente de harvest se crea con `harvest_source_create` (acción de `ckanext-harvest`), indicando `url`, `source_type` (`xlsx_harvester` / `gobar_ckan_harvester` / `ckan_harvester`), `name`, `owner_org`, `frequency` y `config` (JSON con opciones propias de cada harvester). El primer job se dispara con `harvest_job_create` o esperando al cron.

La URL de una fuente debe ser única entre fuentes activas: `harvest_source_delete` hace soft-delete, no libera la URL — para reusarla hay que `dataset_purge` la fuente vieja.
