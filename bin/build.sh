#! /bin/sh
# See https://github.com/accso/docker-pentaho-pdi

if [ "$http_proxy" != "" ] ; then
    PROXY_OPTS="${PROXY_OPTS} --build-arg http_proxy=${http_proxy} --build-arg HTTP_PROXY=${http_proxy}"
fi
if [ "$https_proxy" != "" ] ; then
    PROXY_OPTS="${PROXY_OPTS} --build-arg https_proxy=${https_proxy} --build-arg HTTPS_PROXY=${https_proxy}"
fi

docker build . ${PROXY_OPTS} -t accso/docker-pentaho-pdi:latest
