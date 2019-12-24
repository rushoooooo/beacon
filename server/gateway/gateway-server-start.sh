#!/bin/sh

CUR_DIR=$(readlink -f $(dirname "$0"))
NGINX_CONF=/usr/share/nginx
CONTAINER="gateway_nginx"

if [[ ! -L $NGINX_CONF ]]; then
	rm -rf $NGINX_CONF
	ln -s $CUR_DIR/nginx $NGINX_CONF
fi

if [[ ! -d "/var/log/nginx" ]]; then
	mkdir -p /var/log/nginx
fi

FOUND="`docker ps -a | grep -o ${CONTAINER}`"
if [[ "x$FOUND" = "x" ]]; then
	docker run --name gateway_nginx -d -p 80:80  -v /usr/share/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /var/log/nginx:/var/log/nginx -v /usr/share/nginx/html:/usr/share/nginx/html nginx
else
	docker start $CONTAINER
fi
