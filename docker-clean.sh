#!/usr/bin/env bash

IMAGES=$(docker images | grep none | awk '{ print $3}')
[ -n "${IMAGES}" ] && docker rmi ${IMAGES}

VOLUMES=$(docker volume ls -q )
[ -n "${VOLUMES}" ] && docker volume rm ${VOLUMES}

NETWORKS=$(docker network ls | grep "_default")
[ -n "${NETWORKS}" ] && docker network rm ${NETWORKS}

PROCS=$(docker ps -a | grep "Exit [1-255]" | awk '{ print $1 }')
[ -n "${PROCS}" ] && docker rm -v ${PROCS}
