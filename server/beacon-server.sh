#!/bin/sh

function update_images(){
	docker pull nginx
	docker pull redis
}

if [ $# -gt 0 ]
then
	if [[ $1 = "update" ]]; then
		update_images
	fi
else
	echo ""
	echo "Usage:"
	echo "$0 update			: pull and update all docker images"
fi
