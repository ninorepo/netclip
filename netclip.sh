#!/bin/bash

#ABSPATH_PLACEHOLDER_HER_E
#ABSPATH_PLACEHOLDER_HERE

port=8080
if [[ $# -eq 0 ]]; then
	echo "run on: "
	echo $(hostname -I) | grep -oE '192\.168\.[0-9]+\.[0-9]+' | sed 's/ /\
	/g'
	echo "port:"
	echo $port
	busybox httpd -f -vv -p $port -h "$abspath"/www > /dev/null 2>&1 &
	exit 0
fi

if [[ $1 == "port" ]]; then
	port=$2
	if [[ -n "$2" ]]; then
		killall busybox
		pkill busybox
		echo "run on: "
		echo $(hostname -I) | grep -oE '192\.168\.[0-9]+\.[0-9]+' | sed 's/ /\
		/g'
		echo "port:"
		echo $port
		busybox httpd -f -vv -p $port -h "$abspath"/www > /dev/null 2>&1 &
		exit 0
	else
		echo "FAILED: please set the port properly"
		exit 1
	fi
elif [[ $1 == "stop" ]]; then
	killall busybox
	pkill busybox
	exit 0
else
	"$abspath"/lib/helper.sh $@
fi
