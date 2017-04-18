#!/bin/sh

CONTAINER=frontend
FRONTENDRUNNING="true"

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  FRONTENDRUNNING="false"
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  FRONTENDRUNNING="false"
fi
if  [ "$FRONTENDRUNNING" == "false" ]; then

    docker build . -t manklar/traefikv2:latest

    docker run -d -p 8080:8080 -p 80:80 --name=frontend  --restart=always -v /var/run/docker.sock:/var/run/docker.sock manklar/traefikv2

    docker network create frontend

    docker network connect frontend frontend
fi