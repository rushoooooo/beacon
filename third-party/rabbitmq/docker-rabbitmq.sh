#!/bin/sh
DOCKER_IMG_NAME="rabbitmq:3.8.2-management"
NAME="rabbitmq"
CUR_DIR=$(readlink -f $(dirname $0))

function start_server()
{
  FOUND="`docker ps -a | grep -o "$NAME"`"

  if [[ ! -L "/usr/share/rabbitmq" ]]; then
	rm -rf /usr/share/rabbitmq
	ln -s ${CUR_DIR}/config /usr/share/rabbitmq
  fi

  if [[ "x$FOUND" = "x"  ]]; then
  	docker run -d --name $NAME -p 5672:5672 -p 8080:15672 -v /usr/share/rabbitmq:/var/rabbitmq --hostname rabbitmq_node1 -v /usr/share/rabbitmq/etc:/etc/rabbitmq -v /usr/share/rabbitmq/lib:/var/lib/rabbitmq  -v /usr/share/rabbitmq/log:/var/log/rabbitmq  -e RABBITMQ_DEFAULT_VHOST=lkf_rabbitmq_vhost  -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=admin $DOCKER_IMG_NAME
  else
	docker start $NAME
  fi
}

function stop_server()
{
  FOUND="`docker ps -a | grep -o "$NAME"`"
  if [[ "x$FOUND" = "x" ]]; then
	echo "$NAME not running"
  else
	 docker stop $NAME
  fi
}

function restart_server()
{
  stop_server
  start_server
}

function remove_image()
{
 FOUND="`docker ps -a | grep -o "$NAME"`"
 if [[ "x$FOUND" = "x" ]]; then
 	echo "did not found image"
 else
 	docker rm $NAME
 fi
}

if [[ $# -gt 0 ]]; then
	if [[ "$1" = "start" ]]; then
		start_server
	elif [[ "$1" = "stop" ]]; then
		stop_server
	elif [[ "$1" = "restart" ]]; then
		restart_server
	elif [[ "$1" = "remove" ]]; then
		remove_image
	fi
else
	echo ""
	echo "Usage:"
	echo "$0 start		-	start rabbitmq server"
	echo "$0 stop		-	stop rabbitmq server"
	echo "$0 restart	-	restart rabbit server"
	echo "$0 remove		-	remove created image"
fi
