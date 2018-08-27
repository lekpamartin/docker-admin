#!/bin/sh

. ./docker-admin.conf

if [ $# == 0 ]; then
	$DAEMON ps -a
	exit 0
fi
 
while true ; do
	case "$1" in
		a|start) 
			$DAEMON ps
			exit 0;;
		o|stop)
                        $DAEMON ps -a | grep -v "Up "
                        exit 0;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'.\n"
			#usage
			exit 2;;
	esac
done
 
exit 0
