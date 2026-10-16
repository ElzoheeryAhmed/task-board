FROM postgres:16

USER root
RUN apt-get update \
 && apt-get upgrade -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /usr/local/bin/gosu
USER postgres

EXPOSE 5432