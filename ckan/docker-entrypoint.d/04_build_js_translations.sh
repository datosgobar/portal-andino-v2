#!/bin/bash

# Genera el catálogo de traducciones para JavaScript (servido en /api/i18n/<lang>).
# En dev lo hace `ckan run` al arrancar; en prod (uwsgi) nadie lo construye,
# por lo que los strings JS (ej. el modal del filtro espacial) quedan en inglés.
ckan -c $CKAN_INI translation js
