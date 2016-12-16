#!/bin/sh
# RUN ONLY THE FIRST TIME

docker run -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock --name=traefik pbc/traefik
docker network create traefik
docker network connect traefik traefik
