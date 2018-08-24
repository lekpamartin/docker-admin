#!/bin/sh

if [ $# == 0 ]; then
	docker ps -a
	exit 0
fi
 
#eval set -- "$OPTS"

while true ; do
	case "$1" in
		a|start) 
			docker ps
			exit 0;;
		o|stop)
                        docker ps -a | grep -v "Up "
                        exit 0;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'.\n"
			#usage
			exit 2;;
	esac
done
 
exit 0
