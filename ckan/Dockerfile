FROM ckan/ckan-base:2.11

USER root

# Instalar dependencias del sistema para spatial
RUN apt-get install -y python3-dev libxml2-dev libxslt1-dev libgeos-c1v5

# Instala supervisor y cron, copia archivos de configuración y otorga permisos de escritura para el usuario ckan
RUN apt-get install -y supervisor cron && chown -R ckan:ckan-sys /var/log/supervisor
COPY supervisor/* /etc/supervisor/conf.d/

USER ckan

################################
#INSTALA EXTENSIONES NECESARIAS
################################

### Spatial ###
RUN pip3 install -e 'git+https://github.com/ckan/ckanext-spatial.git@v2.3.1#egg=ckanext-spatial' && \
    pip3 install -r ${APP_DIR}/src/ckanext-spatial/requirements.txt

### Geoview ###
RUN pip3 install -e 'git+https://github.com/ckan/ckanext-geoview.git@master#egg=ckanext-geoview'

###Hierarchy###
RUN pip3 install -e "git+https://github.com/ckan/ckanext-hierarchy.git#egg=ckanext-hierarchy"

### DCAT ###
RUN  pip3 install -e git+https://github.com/ckan/ckanext-dcat.git@v2.4.2#egg=ckanext-dcat && \
    pip3 install -r https://raw.githubusercontent.com/ckan/ckanext-dcat/v2.4.2/requirements.txt

##################################
### LIBRERIAS DE DATOS GOBAR #####
##################################

### Spatial Widget AR ###
RUN pip3 install -e 'git+https://github.com/datosgobar/ckanext-spatial-widget-ar.git@master#egg=ckanext-spatial-widget-ar'

### GobAr theme ###
RUN pip3 install -e 'git+https://github.com/datosgobar/ckanext-gobar-theme.git@main#egg=ckanext-gobar_theme'

### Harvester ###
RUN pip3 install -e 'git+https://github.com/datosgobar/ckanext-gobar-harvest.git@master#egg=ckanext-gobar-harvest' && \
    pip3 install -r ${APP_DIR}/src/ckanext-gobar-harvest/pip-requirements.txt
# will also require gather_consumer and fetch_consumer processes running (please see https://github.com/ckan/ckanext-harvest)

### Scheming ###
RUN pip3 install -e "git+https://github.com/datosgobar/ckanext-scheming-gobar@master#egg=ckanext-scheming-gobar"


############################
### EJECUCION DE SCRIPTS ###
############################

# Copy custom initialization scripts
COPY --chown=ckan-sys:ckan-sys docker-entrypoint.d/* /docker-entrypoint.d/

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY --chown=ckan-sys:ckan-sys patches ${APP_DIR}/patches

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done
