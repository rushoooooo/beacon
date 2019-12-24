#!/bin/sh
CUR_DIR=$(readlink -f $(dirname $0))
CONTAINER="cache-serv"

if [[ ! -L /usr/share/redis ]]; then
	rm -rf /usr/share/redis
	ln -s $CUR_DIR /usr/share/redis
fi

FOUND="`docker ps -a | grep -o "$CONTAINER"`"
if [[ "x$FOUND" = "x" ]]; then
	docker run -p 6379:6379 --name $CONTAINER -v /usr/share/redis/conf/redis.conf:/etc/redis/redis.conf -v /usr/share/redis/data:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes
else
	docker start $CONTAINER
fi
