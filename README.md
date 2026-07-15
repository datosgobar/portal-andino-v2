# Portal Andino V2

Stack dockerizado de [CKAN](https://ckan.org/) 2.11 para los portales de datos abiertos de Datos Argentina, con extensiones propias:

- [ckanext-gobar-theme](https://github.com/datosgobar/ckanext-gobar-theme): theme e identidad visual.
- [ckanext-scheming-gobar](https://github.com/datosgobar/ckanext-scheming-gobar): esquema de metadatos (perfil `datgobar`) — ver [readme-scheming.md](readme-scheming.md).
- [ckanext-gobar-harvest](https://github.com/datosgobar/ckanext-gobar-harvest): cosecha de catálogos externos — ver [readme-harvest.md](readme-harvest.md).
- [ckanext-spatial-widget-ar](https://github.com/datosgobar/ckanext-spatial-widget-ar) y `ckanext-spatial`: búsqueda y mapas espaciales — ver [readme-spatial.md](readme-spatial.md).

## Quickstart (dev)

```
cp .env.example .env
# completar secretos (CKAN___BEAKER__SESSION__SECRET, API_TOKEN__JWT__*, CKAN_SYSADMIN_*, SMTP)
bin/compose up -d --build
```

`bin/compose` es un atajo a `docker compose -f docker-compose.dev.yml`. El sitio queda en `http://localhost:${CKAN_PORT_HOST}` (default `5000`).

Otros atajos en `bin/`:

- `bin/ckan <args>`: corre `ckan` dentro del contenedor `ckan-dev` (ej. `bin/ckan db upgrade`).
- `bin/shell`: shell dentro de `ckan-dev`.
- `bin/reload`: reinicia el proceso Python de `ckan-dev` (recarga `plugin.py`/templates sin rebuildear la imagen).
- `bin/restart`: `docker compose restart ckan-dev`.
- `bin/reset`: limpia volúmenes y reconstruye todo desde cero (**destructivo**).
- `bin/install_src`: corre `install_src.sh` dentro de un contenedor descartable.
- `bin/generate_extension`: `ckan generate extension` con el usuario del host, para scaffolding de una extensión nueva en `src/`.

## Dev vs prod

- `docker-compose.dev.yml` (proyecto `portal-andino-v2-dev`): monta `./src` en `/srv/app/src_extensions` para desarrollar extensiones en caliente; expone el puerto de CKAN directo y el de Solr (`8983`).
- `docker-compose.yml` (proyecto `portal-andino-v2`): sin nginx delante en dev, con nginx + healthchecks en prod; el código de las extensiones vive horneado en la imagen (`ckan/Dockerfile`), no se monta ningún volumen sobre `/srv/app`.

Los dos usan nombres de proyecto Docker distintos a propósito, para no compartir contenedores/volúmenes entre sí.

## Servicios

`nginx` (solo prod) → `ckan` / `ckan-dev` → `db` (Postgres), `solr` (+ `solr-init`, agrega el campo espacial), `redis` (cola de harvest y sesiones), `datapusher`, `ckan-worker` (consumers de harvest + cron, vía `supervisord`).

## Extensiones habilitadas (`CKAN__PLUGINS`)

Un único perfil: todas las extensiones (theme, scheming, harvest, spatial) están siempre activas en `.env.example`. `envvars` debe ir **al final** de `CKAN__PLUGINS` para que termine de resolver las variables `CKAN___*`/`CKAN__*` de configuración.
