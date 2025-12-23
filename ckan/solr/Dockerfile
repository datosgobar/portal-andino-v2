ARG SOLR_VERSION=2.11-solr9
FROM ckan/ckan-solr:${SOLR_VERSION}

USER root
RUN cd /opt/solr/server/solr-webapp/webapp/WEB-INF/lib && \
    wget -q https://repo1.maven.org/maven2/org/locationtech/jts/jts-core/1.19.0/jts-core-1.19.0.jar
USER solr