# Scheming

Se instaló [ckanext-scheming](https://github.com/ckan/ckanext-scheming) para definir el esquema de metadatos de datasets (perfil `datgobar`, ver [ckanext-scheming-gobar](https://github.com/datosgobar/ckanext-scheming-gobar)).

## Instalación

En `ckan/Dockerfile.dev`:

```
RUN cd ${APP_DIR}/src/
RUN pip3 install -e "git+https://github.com/ckan/ckanext-scheming.git#egg=ckanext-scheming"
```

## Configuración

Variables en `.env` (el prefijo `CKAN` debe llevar **3 underscores**, según `ckanext-envvars`):

```
CKAN___SCHEMING__DATASET_SCHEMAS=ckanext.scheming:ckan_dataset_datgobar.yaml
CKAN___SCHEMING__PRESETS=ckanext.scheming:presets.json
```

Para que estas variables tomen efecto, `scheming_datasets` y `envvars` deben estar listados en `CKAN__PLUGINS` (`envvars` **al final**).

## Schemas locales (dev)

En dev, los schemas se montan desde `./src/custom_schemas`. Agregar en `docker-compose.dev.yml`, sección `volumes` del servicio `ckan-dev`:

```
- ./src/custom_schemas:/srv/app/src/ckanext-scheming/ckanext/scheming/schemas
```

Así, la ruta `ckanext.scheming:schemas/datgobar_schema.yaml` resuelve dentro del paquete instalado.
