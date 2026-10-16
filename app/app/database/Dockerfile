FROM postgres:16

USER root
RUN apt-get update \
 && apt-get upgrade -y \
 && rm -rf /var/lib/apt/lists/*

USER postgres

EXPOSE 5432