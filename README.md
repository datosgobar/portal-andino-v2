# Scheming para Portal de Datos Abiertos

Se instaló el [plugging scheming de CKAN](https://github.com/ckan/ckanext-scheming/tree/master) siguiendo las instrucciones provistas en la documentación del mismo. Puntualmente en el Dockerfile.dev dentro de la carpeta CKAN se agregó esto:

RUN cd ${APP_DIR}/src/
RUN pip3 install -e "git+https://github.com/ckan/ckanext-scheming.git#egg=ckanext-scheming"

Así mismo se setearon las siguientes variables de entorno en el .env de acuerdo a lo estipulando en ckanext-envars para setear variables de configuración en el .env:

CKAN___SCHEMING__DATASET_SCHEMAS = ckanext.scheming:schemas/datgobar_schema.yaml
CKAN___SCHEMING__PRESETS= ckanext.scheming:presets.json

el prefijo CKAN debe ir seguido de **3 underscore**.

Para que esas variables de entorno funcionen, es necesario haber listado dataset_scheming y envvars dentro de la variable CKAN_PLUGGINS en el .env.

Los schemas para el portal de guardan en la carpeta src local.Se debe agregar en el docker-compose.dev.yaml en la sección volumes la siguiente linea

  - ./src/custom_schemas:/srv/app/src/ckanext-scheming/ckanext/scheming/schemas
    
De esta forma se montarán los schemas dentro del paquete scheming y de esta forma funcionará esta ruta ckanext.scheming:schemas/datgobar_schema.yaml
